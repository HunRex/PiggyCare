import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:piggycare/enums/level.dart';
import 'package:piggycare/models/appState.dart';
import 'package:piggycare/models/piggy/piggy.export.dart';
import 'package:piggycare/screens/saving.details.dart';
import 'package:redux/redux.dart';

import 'piggy.saving.type.input.dart';

class SavingForListWidget extends StatefulWidget {
  const SavingForListWidget({Key key, this.savingPerFeed}) : super(key: key);

  final int savingPerFeed;
  @override
  _SavingForWidgetState createState() => _SavingForWidgetState();
}

class _SavingForWidgetState extends State<SavingForListWidget> {
  int selectedIndex;
  var savingTypeList = List<SavingTypeInput>();

  _selectItem(int index, Store<AppState> store) {
    var piggy = store.state.user.piggies
        .singleWhere((element) => element.id == index, orElse: null);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SavingDetails(
                  piggy: piggy,
                )));
  }

  _getSavingTypeList() {
    var store = StoreProvider.of<AppState>(context);

    int i = 0;
    savingTypeList = store.state.user.piggies
        .where((element) => element.isApproved ?? false)
        .map((p) {
      i++;
      return SavingTypeInput(
        index: i,
        name: p.item,
        id: p.id,
        coinValue: widget.savingPerFeed != 0
            ? ((p.targetPrice - p.currentSaving) / widget.savingPerFeed).ceil()
            : 0,
        selectIndex: (i) => _selectItem(i, store),
      );
    }).toList();
    if (selectedIndex != null) {
      savingTypeList = savingTypeList.map((f) {
        if (f.index == selectedIndex) {
          return SavingTypeInput(
            coinValue: f.coinValue,
            index: f.index,
            id: f.id,
            selected: true,
            name: f.name,
            selectIndex: (i) => _selectItem(i, store),
          );
        } else {
          return f;
        }
      }).toList();
    }

    return savingTypeList;
  }

  Piggy getSelected() {
    var selected = savingTypeList.singleWhere((t) => t.selected == true);

    var piggy = new Piggy(
      currentSaving: 0,
      doubleUp: false,
      isApproved: false,
      isFeedAvailable: false,
      item: selected.name,
      money: 0,
      targetPrice: selected.coinValue,
      piggyLevel: PiggyLevel.Baby,
    );

    return piggy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, store) => ListView(
          children: _getSavingTypeList(),
        ),
      ),
    );
  }
}

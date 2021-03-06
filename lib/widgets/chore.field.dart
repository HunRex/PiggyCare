import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piggycare/models/appState.dart';
import 'package:piggycare/models/chore/chore.action.dart';
import 'package:piggycare/services/chore.firebase.dart';
import 'package:piggycare/services/notification.modals.dart';

class ChoreInput extends StatefulWidget {
  const ChoreInput(
      {Key key,
      @required this.index,
      @required this.name,
      this.selected,
      this.selectIndex,
      this.userId,
      this.parentId,
      @required this.taskId,
      this.isDone})
      : super(key: key);

  final int index;
  final int taskId;
  final String name;
  final String userId;
  final String parentId;
  final bool selected;
  final bool isDone;
  final Function(int) selectIndex;

  @override
  _ChoreInputState createState() => _ChoreInputState();
}

class _ChoreInputState extends State<ChoreInput> with TickerProviderStateMixin {
  bool selected = false;
  _selectType() {
    widget.selectIndex(widget.index);
  }

  Future<void> _askFinishChore(BuildContext context) async {
    var ack = await showChildrenFinishTaskSubmit(context);

    if (ack ?? false) {
      await ChoreFirebaseServices.finishChildChore(
          widget.userId, widget.taskId, widget.parentId);
      StoreProvider.of<AppState>(context)
          .dispatch(FinishChore(widget.userId, widget.taskId));
    }

    widget.selectIndex(null);
  }

  @override
  void initState() {
    selected = widget.selected ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selected = widget.selected ?? false;
    var width = MediaQuery.of(context).size.width;

    final Color background = Colors.white;
    final Color fill = Theme.of(context).primaryColor;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = width * 0.045;
    final double fillStop = (100 - (selected ? fillPercent : 0)) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    Color color;
    Color textColor;

    if (!widget.isDone) {
      color = selected ? Theme.of(context).primaryColor : Colors.white;
      textColor = selected ? Theme.of(context).primaryColor : Colors.grey;
    } else {
      color = Colors.green;
      textColor = Colors.green;
    }

    TextStyle textStyle =
        TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 17);
    return GestureDetector(
      onTap: () async => selected ? _askFinishChore(context) : _selectType(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
            width: width * 0.8,
            height: MediaQuery.of(context).size.height * 0.095,
            decoration: new BoxDecoration(
                border: new Border.all(color: color),
                color: Colors.white,
                gradient: LinearGradient(colors: gradient, stops: stops),
                borderRadius: BorderRadius.circular(70.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${widget.index.toString()}.",
                        style: textStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              ((widget.selected ?? false) ? 0.46 : 0.55),
                          child: Text(
                            widget.name,
                            style: textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: width * 0.085,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Image.asset("assets/coin.png"),
                          )
                        ],
                      ),
                    ),
                    selected
                        ? Padding(
                            padding:
                                const EdgeInsets.only(right: 26.0, left: 0),
                            child: Container(
                              margin: EdgeInsets.only(right: 0),
                              width: width * 0.035,
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: Center(
                                  child: Icon(FontAwesomeIcons.check,
                                      color: Colors.white)),
                            ),
                          )
                        : Container()
                  ],
                )
              ],
            )),
      ),
    );
  }
}

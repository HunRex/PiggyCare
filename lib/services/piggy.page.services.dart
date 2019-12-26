import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:piggybanx/enums/level.dart';
import 'package:piggybanx/localization/Localizations.dart';
import 'package:piggybanx/models/appState.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

Widget getFeedAnimation(
    BuildContext context, Store<AppState> store, int feedRandom) {
  try {
    return AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 1500),
        child: Image.asset(
            'assets/animations/${levelStringValue(store.state.user.piggyLevel)}-Feed$feedRandom.gif',
            gaplessPlayback: true,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.2));
  } catch (err) {
    return Image.asset(
        'assets/animations/${levelStringValue(store.state.user.piggyLevel)}-Feed$feedRandom.gif',
        gaplessPlayback: true,
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.2);
  }
}

showDemoOverDialog(BuildContext context) async {
  var loc = PiggyLocalizations.of(context);

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.trans("congratulations"),
              style: Theme.of(context).textTheme.display3),
          content: Text(loc.trans("demo_over_dialog_content")),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

Future<void> loadAnimation(
    bool isLevelUp,
    bool showDemoOverAlert,
    TickerProviderStateMixin tickerProviderStateMixin,
    BuildContext context,
    Store<AppState> store) async {
  AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 7500),
      vsync: tickerProviderStateMixin)
    ..forward();

  var animation = new Tween<double>(begin: 0, end: 300).animate(_controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        imageCache.clear();
        Navigator.of(context).pop();
        _controller.dispose();
      }
    });

  Future.delayed(Duration(milliseconds: 250), () {
    AudioCache().play("coin_sound.mp3");
    Vibration.vibrate(duration: 750);
  });
  var prefs = await SharedPreferences.getInstance();
  var feedRandom = prefs.getInt("animationCount");
  if (isLevelUp) {
    prefs.setInt("animationCount", 1);
  } else {
    prefs.setInt("animationCount", feedRandom + 1);
  }

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            _controller.dispose();
            imageCache.clear();
          },
          child: Container(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Hero(
                tag: "piggy",
                child: (isLevelUp)
                    ? Image.asset(
                        'assets/animations/${levelStringValue(PiggyLevel.values[store.state.user.piggyLevel.index - 1])}-LevelUp.gif',
                        gaplessPlayback: true,
                      )
                    : (Image.asset(
                        'assets/animations/${levelStringValue(PiggyLevel.values[store.state.user.piggyLevel.index])}-Feed$feedRandom.gif')),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFce475e),
          ),
        );
      });
}
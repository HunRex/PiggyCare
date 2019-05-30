import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:piggybanx/Enums/period.dart';
import 'package:piggybanx/models/registration/registration.model.dart';
import 'package:piggybanx/models/store.dart';
import 'package:piggybanx/models/user/user.model.dart';
import 'package:piggybanx/screens/main.screen.dart';
import 'package:piggybanx/screens/piggyTryOut.dart';
import 'package:piggybanx/screens/register/register.screen.dart';
import 'package:piggybanx/screens/register/second.screen.dart';
import 'package:piggybanx/screens/startup.screen.dart';
import 'package:redux/redux.dart';
import 'package:piggybanx/models/store.reducer.dart';

var width = 0.0;
var height = 0.0;

void main() {
  var primaryColor = new Color(0xffe25979);
  var primaryDark = new Color(0xffb1264c);
  
  var registrationState = new RegistrationData(item: "", phoneNumber: "", targetPrice: 0);
  var userState = new UserData(
    created: DateTime.now(),
    feedPerPeriod: 0,
    id: "",
    lastFeed: DateTime.now(),
    money: 0,
    period: Period.demo,
    phoneNumber: "",
    saving: 0
  );

  final store = new Store<AppState>(applicationReducer, initialState: new AppState(registrationData: registrationState, user: userState));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MaterialApp(
          home: StoreProvider(
            store: store,
            child: StartupPage(store: store),
          ),
          theme: ThemeData(
            primaryColor: primaryColor,
            fontFamily: 'Montserrat',
            primaryColorDark: primaryDark,
            primaryTextTheme: TextTheme(
              display1: TextStyle(
                  color: primaryColor,
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold),
              display2: TextStyle(
                  color: primaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
              display3: TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              display4: TextStyle(
                  color: primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: new Color(0xffd2576b),
            textTheme: TextTheme(
              display1: TextStyle(
                  color: primaryColor,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold),
              display2: TextStyle(
                  color: primaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
              display3: TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              display4: TextStyle(
                  color: primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
              title: TextStyle(
                  color: primaryDark,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          routes: {
            '': (context) => new RegisterPage(store: store),
            'tryOut': (context) => new PiggyTestPage(),
            'home': (context) => new MainPage(store: store),
            'register': (context) => new FirstRegisterPage(store: store)
          }),
    );
  });
}

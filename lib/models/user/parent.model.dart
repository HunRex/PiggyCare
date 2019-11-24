import 'package:piggybanx/models/user/child.model.dart';
import 'package:piggybanx/models/user/user.model.dart';

class Parent extends UserData {
  List<Child> children;

  Parent.fromParent(Parent another) {
    feedPerPeriod = another.feedPerPeriod;
    id = another.id;
    lastFeed = another.lastFeed;
    items = another.items;
    money = another.money;
    currentFeedTime = another.currentFeedTime;
    piggyLevel = another.piggyLevel;
    period = another.period;
    phoneNumber = another.phoneNumber;
    saving = another.saving;
    isDemoOver = another.isDemoOver;
    created = another.created;
    children = another.children;
  }
}
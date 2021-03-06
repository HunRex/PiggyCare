import 'package:piggycare/Enums/userType.dart';
import 'package:piggycare/models/SavingSchedule.dart';

class RegistrationData {
  String phoneNumber;
  String email;
  String username;
  String item;
  UserType userType;
  int targetPrice;
  Schedule schedule;
  String uid;
  String pictureUrl;

  RegistrationData(
      {this.item,
      this.phoneNumber,
      this.targetPrice,
      this.schedule,
      this.userType,
      this.uid,
      this.email,
      this.username,
      this.pictureUrl});
}

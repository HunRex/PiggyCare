// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map json, String documentId) {
  return UserData(
    id: json['id'] as String,
    documentId: documentId,
    saving: json['saving'] as int,
    userType: _$enumDecode(_$UserTypeEnumMap, json['userType']),
    feedPerPeriod: json['feedPerPeriod'] as int,
    period: _$enumDecode($PeriodEnumMap, json['period']),
    piggies:
        (json['piggies'] as List).map((e) => Piggy.fromJson(e as Map)).toList(),
    piggyLevel: _$enumDecode(_$PiggyLevelEnumMap, json['piggyLevel']),
    currentFeedTime: json['currentFeedTime'] as int,
    money: (json['money'] as num).toDouble(),
    lastFeed: DateTime.parse(json['lastFeed'] as String),
    created: DateTime.parse(json['created'] as String),
    email: json['email'] as String,
    name: json['name'] as String,
    pictureUrl: json['pictureUrl'] as String,
  );
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'saving': instance.saving,
      'userType': _$UserTypeEnumMap[instance.userType],
      'period': $PeriodEnumMap[instance.period],
      'feedPerPeriod': instance.feedPerPeriod,
      'piggies': instance.piggies.map((f) => f.toJson()).toList(),
      'piggyLevel': _$PiggyLevelEnumMap[instance.piggyLevel],
      'currentFeedTime': instance.currentFeedTime,
      'lastFeed': instance.lastFeed.toIso8601String(),
      'created': instance.created.toIso8601String(),
      'money': instance.money,
      'email': instance.email,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$UserTypeEnumMap = {
  UserType.business: 'business',
  UserType.donator: 'donator',
};

const $PeriodEnumMap = {
  Period.demo: 'demo',
  Period.daily: 'daily',
  Period.weely: 'weely',
  Period.monthly: 'monthly',
};

const _$PiggyLevelEnumMap = {
  PiggyLevel.Baby: 'Baby',
  PiggyLevel.Child: 'Child',
  PiggyLevel.Teen: 'Teen',
  PiggyLevel.Adult: 'Adult',
  PiggyLevel.Old: 'Old',
};

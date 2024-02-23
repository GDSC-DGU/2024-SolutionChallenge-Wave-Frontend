// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      totalWave: json['totalWave'] as int,
      donationCountryCnt: json['donationCountryCnt'] as int,
      firstBadge: json['firstBadge'] as bool,
      secondBadge: json['secondBadge'] as bool,
      thirdBadge: json['thirdBadge'] as bool,
      fourthBadge: json['fourthBadge'] as bool,
      fifthBadge: json['fifthBadge'] as bool,
      sixthBadge: json['sixthBadge'] as bool,
      seventhBadge: json['seventhBadge'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'totalWave': instance.totalWave,
      'donationCountryCnt': instance.donationCountryCnt,
      'firstBadge': instance.firstBadge,
      'secondBadge': instance.secondBadge,
      'thirdBadge': instance.thirdBadge,
      'fourthBadge': instance.fourthBadge,
      'fifthBadge': instance.fifthBadge,
      'sixthBadge': instance.sixthBadge,
      'seventhBadge': instance.seventhBadge,
    };

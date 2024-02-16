// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      nickname: json['nickname'] as String,
      totalWave: json['totalWave'] as int,
      donationCountryCnt: json['donationCountryCnt'] as int,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'totalWave': instance.totalWave,
      'donationCountryCnt': instance.donationCountryCnt,
    };

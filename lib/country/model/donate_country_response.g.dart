// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountryResponse _$DonateCountryResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountryResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountryModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountryResponseToJson(
        DonateCountryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

DonateCountryModel _$DonateCountryModelFromJson(Map<String, dynamic> json) =>
    DonateCountryModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      allWave: json['allWave'] as int,
      lastWave: json['lastWave'] as int,
      casualties: json['casualties'] as int,
      id: json['id'] as int,
    );

Map<String, dynamic> _$DonateCountryModelToJson(DonateCountryModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'allWave': instance.allWave,
      'lastWave': instance.lastWave,
      'casualties': instance.casualties,
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountriesResponse _$DonateCountriesResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountriesResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DonateCountriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountriesResponseToJson(
        DonateCountriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

DonateCountriesModel _$DonateCountriesModelFromJson(
        Map<String, dynamic> json) =>
    DonateCountriesModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      allWave: json['allWave'] as int,
      lastWave: json['lastWave'] as int,
      casualties: json['casualties'] as int,
    );

Map<String, dynamic> _$DonateCountriesModelToJson(
        DonateCountriesModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'allWave': instance.allWave,
      'lastWave': instance.lastWave,
      'casualties': instance.casualties,
    };

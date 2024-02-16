// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_countries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      id: json['id'] as int,
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
      'id': instance.id,
    };

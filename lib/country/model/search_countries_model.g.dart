// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_countries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountriesModel _$SearchCountriesModelFromJson(
        Map<String, dynamic> json) =>
    SearchCountriesModel(
      category: json['category'] as String,
      mainTitle: json['mainTitle'] as String,
      subTitle: json['subTitle'] as String,
      image: json['image'] as String,
      views: json['views'] as int,
      id: json['id'] as int,
    );

Map<String, dynamic> _$SearchCountriesModelToJson(
        SearchCountriesModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'views': instance.views,
      'id': instance.id,
    };

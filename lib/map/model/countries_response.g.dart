// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountriesResponse _$CountriesResponseFromJson(Map<String, dynamic> json) =>
    CountriesResponse(
      success: json['success'] as bool,
      error: json['error'] as String,
      data: ImportantCountriesModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountriesResponseToJson(CountriesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

ImportantCountriesModel _$ImportantCountriesModelFromJson(
        Map<String, dynamic> json) =>
    ImportantCountriesModel(
      emergency: (json['emergency'] as List<dynamic>)
          .map((e) => ImportantCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      alert: (json['alert'] as List<dynamic>)
          .map((e) => ImportantCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      caution: (json['caution'] as List<dynamic>)
          .map((e) => ImportantCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImportantCountriesModelToJson(
        ImportantCountriesModel instance) =>
    <String, dynamic>{
      'emergency': instance.emergency,
      'alert': instance.alert,
      'caution': instance.caution,
    };

ImportantCountryModel _$ImportantCountryModelFromJson(
        Map<String, dynamic> json) =>
    ImportantCountryModel(
      id: json['id'] as int,
      isPossible: json['isPossible'] as bool,
    );

Map<String, dynamic> _$ImportantCountryModelToJson(
        ImportantCountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isPossible': instance.isPossible,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountriesResponse _$SearchCountriesResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCountriesResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'],
    );

Map<String, dynamic> _$SearchCountriesResponseToJson(
        SearchCountriesResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

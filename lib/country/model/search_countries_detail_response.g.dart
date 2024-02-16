// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_countries_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCountriesDetailResponse _$SearchCountriesDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCountriesDetailResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountriesDetailModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$SearchCountriesDetailResponseToJson(
        SearchCountriesDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

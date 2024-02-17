// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_country_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountriesDetailResponse _$DonateCountriesDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DonateCountriesDetailResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : DonateCountryDetailModel.fromJson(
              json['data'] as Map<String, dynamic>),
      error: json['error'],
    );

Map<String, dynamic> _$DonateCountriesDetailResponseToJson(
        DonateCountriesDetailResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

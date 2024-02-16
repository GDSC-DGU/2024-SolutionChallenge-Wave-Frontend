// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateSuccessResponse _$DonateSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    DonateSuccessResponse(
      success: json['success'] as bool,
      data: json['data'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$DonateSuccessResponseToJson(
        DonateSuccessResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': instance.data,
    };

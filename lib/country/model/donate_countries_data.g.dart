// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_countries_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateCountriesData _$DonateCountriesDataFromJson(Map<String, dynamic> json) =>
    DonateCountriesData(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => DonateCountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DonateCountriesDataToJson(
        DonateCountriesData instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };

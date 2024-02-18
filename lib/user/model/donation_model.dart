import 'package:json_annotation/json_annotation.dart';

part 'donation_model.g.dart';

@JsonSerializable()
class DonationModel {
  final String date;
  final String country;
  final String time;
  final int waves;

  DonationModel({
    required this.date,
    required this.country,
    required this.time,
    required this.waves,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) => _$DonationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonationModelToJson(this);
}

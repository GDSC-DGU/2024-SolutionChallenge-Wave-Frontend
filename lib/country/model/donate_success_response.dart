
import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

part 'donate_success_response.g.dart';

@JsonSerializable()
class DonateSuccessResponse extends CommonResponse {
  final String? data;

  DonateSuccessResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory DonateSuccessResponse.fromJson(Map<String, dynamic> json) =>
      _$DonateSuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonateSuccessResponseToJson(this);
}
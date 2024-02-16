import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/common_response.dart';

import '../../user/model/user_info_model.dart';

part 'user_info_response.g.dart';

@JsonSerializable()
class UserInfoResponse extends CommonResponse {
  final UserInfoModel? data;

  UserInfoResponse({
    required bool success,
    this.data,
    dynamic error,
  }) : super(success: success, error: error);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}



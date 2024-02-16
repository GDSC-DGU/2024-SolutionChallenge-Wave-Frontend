import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String nickname;
  final int totalWave;
  final int donationCountryCnt;

  UserInfoModel ({
    required this.nickname,
    required this.totalWave,
    required this.donationCountryCnt,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
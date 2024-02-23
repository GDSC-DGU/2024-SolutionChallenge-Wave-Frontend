import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final int id;
  final String nickname;
  final int totalWave;
  final int donationCountryCnt;
  final bool firstBadge;
  final bool secondBadge;
  final bool thirdBadge;
  final bool fourthBadge;
  final bool fifthBadge;
  final bool sixthBadge;
  final bool seventhBadge;


  UserModel({
    required this.id,
    required this.nickname,
    required this.totalWave,
    required this.donationCountryCnt,
    required this.firstBadge,
    required this.secondBadge,
    required this.thirdBadge,
    required this.fourthBadge,
    required this.fifthBadge,
    required this.sixthBadge,
    required this.seventhBadge,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
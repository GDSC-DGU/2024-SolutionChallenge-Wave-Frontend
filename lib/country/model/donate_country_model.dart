

import 'package:json_annotation/json_annotation.dart';
import 'package:wave/common/model/i_model_with_id.dart';
import 'package:wave/common/utils/data_utils.dart';

part 'donate_country_model.g.dart';

@JsonSerializable()
class DonateCountryModel implements IModelWithId {
  final String category;
  final String mainTitle;
  final String subTitle;
  final String image;
  final int allWave;
  final int lastWave;
  final int casualties;
  @override
  final int id;

  DonateCountryModel({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
  });

  factory  DonateCountryModel.fromJson(Map<String, dynamic> json) =>
      _$DonateCountryModelFromJson(json);
}
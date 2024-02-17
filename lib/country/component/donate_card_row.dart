import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';
import 'card_vertical_divider.dart';

class DonateCardRow extends StatelessWidget {
  final int allWave;
  final int lastWave;
  final int casualties;

  const DonateCardRow({
    Key? key,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,###");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatColumn('All Waves', '🌊${numberFormat.format(allWave)}', PRIMARY_BLUE_COLOR),
        const CardVerticalDivider(),
        _buildStatColumn('Last Wave', '🌊${numberFormat.format(lastWave)}', Colors.black),
        const CardVerticalDivider(),
        _buildStatColumn('Casualties', numberFormat.format(casualties), Colors.black),
      ],
    );
  }

  Column _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color, // Use the color parameter here
          ),
        ),
      ],
    );
  }
}

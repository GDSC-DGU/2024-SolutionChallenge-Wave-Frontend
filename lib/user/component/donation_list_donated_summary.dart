import 'package:flutter/material.dart';

class DonatedWavesSummary extends StatelessWidget {
  final int totalWave;

  const DonatedWavesSummary({
    Key? key,
    required this.totalWave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 165.0,
          height: 40.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E2E8).withOpacity(0.41),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                'Donated waves',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🌊 $totalWave',
                  style: const TextStyle(
                    color: Color(0xFF247EF4),
                    fontWeight: FontWeight.w600,
                    fontSize: 48,
                  ),
                ),
                Text(
                  'Wave per 1USD / \$${totalWave.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

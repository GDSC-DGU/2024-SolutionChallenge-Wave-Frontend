import 'package:flutter/material.dart';
import 'package:wave/common/layout/default_layout.dart';

class DonationCountryScreen extends StatelessWidget {
  const DonationCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Sending Waves',
      child: Column(
        children: [
          Text('DonationCountryScreen'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DonateCountryLabel extends StatelessWidget {
  final String countryName;

  const DonateCountryLabel({
    Key? key,
    required this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Text(
        countryName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}

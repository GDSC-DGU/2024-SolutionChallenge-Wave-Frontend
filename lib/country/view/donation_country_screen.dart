import 'package:flutter/material.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/component/donate_country_label.dart';

class DonationCountryScreen extends StatelessWidget {
  const DonationCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      title: 'Sending Waves',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DonateCountryLabel(countryName: 'Ukraine'),
            DonateCountryCard(
              category: 'Emergency',
              mainTitle: 'Help the People 🇺🇦',
              subTitle: 'of Ukraine affected by war',
              image: Image.asset(
                'assets/images/testImg.png',
                fit: BoxFit.cover,
              ),
              allWave: 6239,
              lastWave: 355,
              casualties: 490000,
            ),
            const DonateCountryLabel(countryName: 'Yemen'),
            DonateCountryCard(
              category: 'Emergency',
              mainTitle: 'Help the People 🇾🇪',
              subTitle: 'of Yemen affected by war',
              image: Image.asset(
                'assets/images/testImg.png',
                fit: BoxFit.cover,
              ),
              allWave: 6239,
              lastWave: 355,
              casualties: 490000,
            ),
            const DonateCountryLabel(countryName: 'Syria'),
            DonateCountryCard(
              category: 'Emergency',
              mainTitle: 'Help the People 🇸🇾',
              subTitle: 'of Syria affected by war',
              image: Image.asset(
                'assets/images/testImg.png',
                fit: BoxFit.cover,
              ),
              allWave: 6239,
              lastWave: 355,
              casualties: 490000,
            ),
            const DonateCountryLabel(countryName: 'Israel - Palestine'),
            DonateCountryCard(
              category: 'Emergency',
              mainTitle: '🇵🇸Help the People 🇮🇱',
              subTitle: 'of Israel - Palestine by war',
              image: Image.asset(
                'assets/images/testImg.png',
                fit: BoxFit.cover,
              ),
              allWave: 6239,
              lastWave: 355,
              casualties: 490000,
            ),
          ],
        ),
      ),
    );
  }
}

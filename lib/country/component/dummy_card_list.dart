import 'package:flutter/material.dart';
import 'package:wave/country/component/search_countries_card.dart';

Widget _buildHorizontalCardListEmergency() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Emergency',
            mainTitle: 'Help the People 🇺🇦',
            subTitle: 'of Ukraine affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Emergency',
            mainTitle: 'Help the People 🇾🇪',
            subTitle: 'of Yemen affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Emergency',
            mainTitle: 'Help the People 🇸🇾',
            subTitle: 'of Syria affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        // 추가적인 카드들
      ],
    ),
  );
}

Widget _buildHorizontalCardListAlert() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Alert',
            mainTitle: 'Help the People 🇺🇦',
            subTitle: 'of Ukraine affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Alert',
            mainTitle: 'Help the People 🇾🇪',
            subTitle: 'of Yemen affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Alert',
            mainTitle: 'Help the People 🇸🇾',
            subTitle: 'of Syria affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        // 추가적인 카드들
      ],
    ),
  );
}

Widget _buildHorizontalCardListCaution() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Caution',
            mainTitle: 'Help the People 🇺🇦',
            subTitle: 'of Ukraine affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Caution',
            mainTitle: 'Help the People 🇾🇪',
            subTitle: 'of Yemen affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: 'Caution',
            mainTitle: 'Help the People 🇸🇾',
            subTitle: 'of Syria affected by war',
            image: Image.asset(
              'assets/images/testImg.png',
              fit: BoxFit.cover,
            ),
            views: 6239,
            id: 5,
          ),
        ),
        // 추가적인 카드들
      ],
    ),
  );
}
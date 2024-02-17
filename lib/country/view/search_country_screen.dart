import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/see_all_button.dart';
import '../component/donate_countries_card.dart';
import '../component/donate_country_label.dart';
import '../component/search_countries_card.dart';

class SearchCountriesScreen extends ConsumerWidget {
  static String get routeName => 'searchCountry';
  const SearchCountriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      title: 'Attention Countries',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DonateCountryLabel(countryName: 'Emergency'),
                SeeAllButton(onTap: () {
                  print('hallo');
                }),
              ],
            ),
            _buildHorizontalCardListEmergency(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DonateCountryLabel(countryName: 'Alert'),
                SeeAllButton(onTap: () {
                  print('hallo');
                }),
              ],
            ),
            _buildHorizontalCardListEmergencyAlert(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DonateCountryLabel(countryName: 'Caution'),
                SeeAllButton(onTap: () {
                  print('hallo');
                }),
              ],
            ),
            _buildHorizontalCardListCaution(),
          ],
        ),
      ),
    );
  }


}

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
          ),
        ),
        // 추가적인 카드들
      ],
    ),
  );
}

Widget _buildHorizontalCardListEmergencyAlert() {
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
          ),
        ),
        // 추가적인 카드들
      ],
    ),
  );
}
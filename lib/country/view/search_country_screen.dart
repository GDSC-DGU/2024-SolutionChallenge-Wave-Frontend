import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/see_all_button.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import '../component/donate_countries_card.dart';
import '../component/donate_country_label.dart';
import '../component/search_countries_card.dart';

class SearchCountriesScreen extends ConsumerWidget {
  static String get routeName => 'searchCountry';

  const SearchCountriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(searchNotifierProvider.notifier).fetchSearchCountries(); // Trigger data fetch

    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      title: 'Attention Countries',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Emergency'),
            _buildCountryList(context, ref, ref.watch(searchNotifierProvider.notifier).getEmergencyCountries()),
            _buildSectionTitle(context, 'Alert'),
            _buildCountryList(context, ref, ref.watch(searchNotifierProvider.notifier).getAlertCountries()),
            _buildSectionTitle(context, 'Caution'),
            _buildCountryList(context, ref, ref.watch(searchNotifierProvider.notifier).getCautionCountries()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DonateCountryLabel(countryName: title),
      ],
    );
  }

  Widget _buildCountryList(BuildContext context, WidgetRef ref, List<SearchCountryModel> countries) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: countries.map((country) => Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SearchCountryCard(
            category: country.category,
            mainTitle: country.mainTitle,
            subTitle: country.subTitle,
            image: Image.network(
              country.image,
              fit: BoxFit.cover,
            ),
            views: country.views,
            id: country.id,
          ),
        )).toList(),
      ),
    );
  }
}


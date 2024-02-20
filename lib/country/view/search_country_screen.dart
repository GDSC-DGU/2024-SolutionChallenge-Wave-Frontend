import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/see_all_button.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import '../../loading/loading_screen.dart';
import '../component/donate_countries_card.dart';
import '../component/donate_country_label.dart';
import '../component/search_countries_card.dart';

class SearchCountriesScreen extends ConsumerStatefulWidget {
  static String get routeName => 'searchCountry';

  const SearchCountriesScreen({Key? key}) : super(key: key);

  @override
  _SearchCountriesScreenState createState() => _SearchCountriesScreenState();
}

class _SearchCountriesScreenState extends ConsumerState<SearchCountriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(searchNotifierProvider.notifier).fetchSearchCountries()
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchNotifierProvider);

    if (state.state != SearchState.loaded) {
      return const LoadingScreen();
    }
    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      title: 'Attention Countries',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'EMERGENCY'),
            _buildCountryList(context, ref,
                ref.watch(searchNotifierProvider.notifier)
                    .getEmergencyCountries()),
            _buildSectionTitle(context, 'ALERT'),
            _buildCountryList(context, ref,
                ref.watch(searchNotifierProvider.notifier).getAlertCountries()),
            _buildSectionTitle(context, 'CAUTION'),
            _buildCountryList(context, ref,
                ref.watch(searchNotifierProvider.notifier)
                    .getCautionCountries()),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DonateCountryLabel(countryName: title),
        ],
      ),
    );
  }

  Widget _buildCountryList(BuildContext context, WidgetRef ref,
      List<SearchCountryModel> countries) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(6), // 여기서 Row 전체에 대한 패딩을 설정합니다.
            child: Row(
              children: countries.map((country) =>
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    // 각 요소의 오른쪽에만 패딩을 적용합니다.
                    child: SearchCountryCard(
                      category: country.category,
                      mainTitle: country.mainTitle,
                      subTitle: country.subTitle,
                      image: Image.network(
                        country.image,
                        fit: BoxFit.cover,
                      ),
                      views: country.views,
                      id: country.id, country: country.category,
                    ),
                  )).toList(),
            ),
          ),
        ),
        SizedBox(height: 24,),
        Container(
          width: double.infinity, // 화면 전체 너비
          height: 1.5, // 선의 굵기
          color: Colors.black.withOpacity(0.1), // 색상 및 투명도 설정
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}


// DUMMY DATA CODE (BEFORE API)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/component/donate_country_label.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';

class DonateCountriesScreen extends ConsumerWidget {
  static String get routeName => 'donateCountry';
  const DonateCountriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donateCountriesState = ref.watch(donateCountriesNotifierProvider);
    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      title: 'Sending Waves',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DonateCountryLabel(countryName: 'Ukraine'),
            GestureDetector(
              onTap: () {
                print('now?');
                // context.goNamed(DonateCountryDetailScreen.routeName,
                //     pathParameters: {
                //       'id': '1',
                //     });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonateCountryDetailScreen(id: 5),
                  ),
                );
                ///   'id': model.id,
              },
              child: DonateCountryCard(
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

// /// API TEST CODE
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wave/common/layout/default_layout.dart';
// import 'package:wave/country/component/donate_countries_card.dart';
// import 'package:wave/country/component/donate_country_label.dart';
// import 'package:wave/country/provider/donate_country_provider.dart';
// import 'package:wave/loading/loading_screen.dart';
//
// import '../model/donate_country_model.dart';
//
// class DonateCountriesScreen extends ConsumerWidget {
//   const DonateCountriesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final donateCountriesState = ref.watch(donateCountriesNotifierProvider);
//     return DefaultLayout(
//       isSingleChildScrollViewNeeded: false,
//       title: 'Sending Waves',
//       child: donateCountriesState.isLoading
//           ? const LoadingScreen() // 로딩 중
//           : donateCountriesState.error != null
//           ? Text('Error: Server ERROR 입니당!') // 에러 처리
//           : SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: _buildCountriesList(donateCountriesState.data!),
//             ),
//           ),
//     );
//   }
// }
//
// Widget _buildCountriesList(List<DonateCountryModel> countries) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: countries.map((country) => Column(
//       children: [
//         DonateCountryLabel(countryName: country.mainTitle),
//         DonateCountryCard(
//           category: country.category,
//           mainTitle: country.mainTitle,
//           subTitle: country.subTitle,
//           image: Image.network(country.image, fit: BoxFit.cover),
//           allWave: country.allWave,
//           lastWave: country.lastWave,
//           casualties: country.casualties,
//         ),
//       ],
//     )).toList(),
//   );
// }

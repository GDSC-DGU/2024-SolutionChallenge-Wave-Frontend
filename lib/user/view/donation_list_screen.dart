import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/user/model/donation_model.dart';
import '../../loading/loading_screen.dart';
import '../component/donation_list_donated_summary.dart';
import '../component/donation_list_tile.dart';
import '../model/donation_response_model.dart';
import '../provider/user_me_provider.dart';

class DonationListScreen extends ConsumerStatefulWidget {
  const DonationListScreen({Key? key}) : super(key: key);

  static const String routeName = '/donation-list';

  @override
  ConsumerState<DonationListScreen> createState() => _DonationListScreenState();
}

class _DonationListScreenState extends ConsumerState<DonationListScreen> {
  @override
  Widget build(BuildContext context) {
    final donationStateNotifier = ref.watch(userMeProvider.notifier);
    final donationResponse = donationStateNotifier.donationResponse; // 기부 목록 데이터

    // donations 리스트가 null이거나 비어있지 않을 때 리스트를 보여줍니다.
    //final DonationResponseModel donations = donationsDummy; //TODO: dummy data. 나중에 지우기

    if (donationResponse == null) {
      // 로딩 화면 또는 기부 목록이 없는 경우의 처리
      return LoadingScreen();
    } else {
      // 기부 목록이 있는 경우의 UI 구성
      final donations = donationResponse.data.donateList;
      final totalWave = donationResponse.data.totalWave;
      return Scaffold(
        appBar: _buildAppBar(), // _buildAppBar()는 별도로 정의된 상단 바를 반환하는 함수로 가정합니다.
        body: Column(
          children: [
            const SizedBox(height: 20),
            DonatedWavesSummary(
              totalWave: totalWave,
            ),
            const SizedBox(height: 16,),
            SizedBox(
              height: 12,
              child: Container(
                color: const Color(0xFFF1F1F7),
              ),
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: ListView.builder(
                itemCount: donations.length,
                itemBuilder: (context, index) {
                  final donation = donations[index];
                  return DonationListTile(donation: donation.toJson());
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Donation list',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.9),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

//TODO: dummy data. 나중에 지우기
// final DonationResponseModel donationsDummy = DonationResponseModel(
//   success: true,
//   data: DonationResponseData(
//     totalWave: 1000,
//     donateList: [
//       DonationModel(
//         date: '1.27',
//         country: '🇺🇦 Ukraine',
//         time: '22:38',
//         waves: 130,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//       DonationModel(
//         date: '1.27',
//         country: '🇵🇸 Palestine - Israel',
//         time: '17:29',
//         waves: 54,
//       ),
//     ],
//   ),
//   error: null,
// );

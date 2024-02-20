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



      // 기부 목록이 있는 경우의 UI 구성
      final donations = donationResponse?.data.donateList ?? [];
      final totalWave = donationResponse?.data.totalWave ?? 0;
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
            donations.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: donations.length,
                itemBuilder: (context, index) {
                  final donation = donations[index];
                  return DonationListTile(donation: donation.toJson());
                },
              ),
            )
                : Expanded(
              child: Center(
                child: Text(
                  'There is no history of donation.\nPlease give rise to 🌊Wave🌊\nthat will make a difference in the world!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
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
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        iconSize: 24,
      ),
    );
  }
}
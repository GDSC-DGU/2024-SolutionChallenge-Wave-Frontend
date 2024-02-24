import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/user/repository/user_me_repository.dart';
import '../../common/layout/default_layout.dart';
import '../../loading/loading_screen.dart';
import '../model/user_model.dart';
import '../provider/user_me_provider.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  const BadgeScreen({Key? key}) : super(key: key);

  static const String routeName = '/badge';

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

final List<String> countBadgeNames = [
  "First donation", "5th donation", "10th donation", // countBadge 예시
  "50th donation", "100th donation"
];
final List<String> amountBadgeNames = [
  "Reach \$10", "Reach \$100", "Reach \$1000", // countBadge 예시
];

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  bool? isLightOn;

  Future<void> fetchLightStatus() async {
    try {
      final lightResponse = await ref.read(userMeRepositoryProvider).getLight();
      setState(() {
        print('me?');
        isLightOn = lightResponse.data?.isLightOn ?? false;
      });
    } catch (error) {
      print("Light status fetch error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLightStatus();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    UserModel? user;

    if (userState is UserModel) {
      user = userState;
    }

    if (user == null || isLightOn == null) {
      return const LoadingScreen();
    } else {
      print('hehe${user.amountBadges[0]}');
      return DefaultLayout(
        isNeededCenterAppbar: true,
        title: 'Earned badges',
        isSingleChildScrollViewNeeded: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved donation count',
                    style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  _buildBadgeGrid(user.countBadges, 'countBadge'),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Amount of donations achieved',
                style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            _buildBadgeGrid(user.amountBadges, 'amountBadge'),
          ],
        ),
      );
    }
  }
}

Widget _buildBadgeGrid(List<bool> badges, String badgeType) {
  // 뱃지 타입에 따라 이름 배열 선택
  List<String> badgeNames = badgeType == 'countBadge' ? countBadgeNames : amountBadgeNames;

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisExtent: 140,
    ),
    itemCount: badges.length,
    itemBuilder: (context, index) {
      bool isActive = badges[index];
      String badgeAssetPath = isActive
          ? 'assets/icons/badge/$badgeType${index + 1}.png'
          : 'assets/icons/badge/disabled${badgeType.capitalize()}${index + 1}.png';

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            badgeAssetPath,
            height: 100,
          ),
          Text(
            badgeNames[index],
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (!isActive)
            Text(
              'Achieve',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      );
    },
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}



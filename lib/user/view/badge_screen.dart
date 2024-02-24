import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  "50th donation", "500th donation"
];
final List<String> amountBadgeNames = [
  "Reach \$10", "Reach \$100", "Reach \$1000", // countBadge 예시
];

class _BadgeScreenState extends ConsumerState<BadgeScreen> {

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    UserModel? user;

    if (userState is UserModel) {
      user = userState;
    }

    if (user == null) {
      return const LoadingScreen();
    } else {
      return DefaultLayout(
        isNeededCenterAppbar: true,
        title: 'Earned badges',
        isSingleChildScrollViewNeeded: true,
        child: SingleChildScrollView(
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
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    _buildBadgeGrid(user.countBadges, 'countBadge'),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Colors.black.withOpacity(0.1),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Amount of donations achieved',
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              _buildBadgeGrid(user.amountBadges, 'amountBadge'),
            ],
          ),
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
      mainAxisSpacing: 50, // 뱃지와 이름 사이의 간격을 더 넓힘
    ),
    itemCount: badges.length,
    itemBuilder: (context, index) {
      bool isActive = badges[index];
      String badgeAssetPath = isActive
          ? 'assets/icons/badge/$badgeType${index + 1}.png'
          : 'assets/icons/badge/disabled${badgeType.capitalize()}${index + 1}.png';

        return Expanded(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
              badgeAssetPath,
          ),
          const SizedBox(height: 8),
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
      ),
      );
    },
  );
}



extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}



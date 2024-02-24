import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/user/model/donation_model.dart';
import 'package:wave/user/repository/user_me_repository.dart';
import '../../common/layout/default_layout.dart';
import '../../loading/loading_screen.dart';
import '../component/donation_list_donated_summary.dart';
import '../component/donation_list_tile.dart';
import '../model/donation_response_model.dart';
import '../model/user_model.dart';
import '../provider/user_me_provider.dart';

class BadgeScreen extends ConsumerStatefulWidget {
  const BadgeScreen({Key? key}) : super(key: key);

  static const String routeName = '/badge';

  @override
  ConsumerState<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends ConsumerState<BadgeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      await ref.read(userMeProvider.notifier).getMe();
    } catch (error) {
      print("사용자 데이터를 가져오는 중 에러 발생: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userMeProvider);
    UserModel? user;

    if(userState is UserModel){
      user = userState;
    }

    if(user != null){
      return const LoadingScreen();
    }else {
      return DefaultLayout(
      isNeededCenterAppbar: true,
      title: 'Earned badges',
        isSingleChildScrollViewNeeded: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),

          )
    );
  }
}


}

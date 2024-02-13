import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/view/initial_screen.dart';
import 'package:wave/common/view/root_tab.dart';
import 'package:wave/onboarding/first_onboarding_screen.dart';
import 'package:wave/onboarding/second_onboarding_screen.dart';
import 'package:wave/user/provider/user_me_provider.dart';

import '../../splash/splash_screen.dart';
import '../model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [],
        ),
        GoRoute(
          path: '/onboarding1',
          name: FirstOnboardingScreen.routeName,
          builder: (_, __) => FirstOnboardingScreen(),
        ),
        GoRoute(
          path: '/onboarding2',
          name: SecondOnboardingScreen.routeName,
          builder: (_, __) => SecondOnboardingScreen(),
        ),
        GoRoute(
          path: '/initial',
          name: InitialScreen.routeName,
          builder: (_, __) => InitialScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  // SplashScreen
  // 앱을 처음 시작했을때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    return '/';

    // final logginIn = state.matchedLocation == '/login';
    //
    // // 유저 정보가 없는데
    // // 로그인중이면 그대로 로그인 페이지에 두고
    // // 만약에 로그인중이 아니라면 로그인 페이지로 이동
    // if (user == null) {
    //   return logginIn ? null : '/login';
    // }
    //
    // // user가 null이 아님
    //
    // // UserModel
    // // 사용자 정보가 있는 상태면
    // // 로그인 중이거나 현재 위치가 SplashScreen이면
    // // 홈으로 이동
    // if (user is UserModel) {
    //   return logginIn || state.matchedLocation == '/splash' ? '/' : null;
    // }
    //
    // // UserModelError
    // if (user is UserModelError) {
    //   return !logginIn ? '/login' : null;
    // }

    return null;
  }
}

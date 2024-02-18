import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/provider/go_router.dart';
import 'package:wave/map/view/global_map_screen.dart';
import 'package:wave/onboarding/onboarding_screen.dart';
import 'package:wave/user/view/donation_list_screen.dart';
import 'package:wave/user/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wave/user/view/my_page_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'loading/loading_screen.dart';

//⭐️ 아래에 스크린 UI 빌딩 빠르게 볼 수 있는 주석 코드 있음 ⭐️
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

// //// ⭐️ TEST CODE: 아래처럼 UI만 보고 싶을 때 위에 기존거 주석 처리 하고 ✅
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     ProviderScope( // ProviderScope 추가
//       child: _App(),
//     ),
//   );
// }
//
// class _App extends StatelessWidget {
//   const _App({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Pretendard',
//       ),
//       debugShowCheckedModeBanner: false,
//       home: DonationListScreen(), // 여기 원하는 스크린 대입 ✅
//     );
//   }
// }
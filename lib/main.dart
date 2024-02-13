import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/provider/go_router.dart';
import 'package:wave/onboarding/first_onboarding_screen.dart';
import 'package:wave/onboarding/second_onboarding_screen.dart';


//⭐️ 아래에 스크린 UI 빌딩 빠르게 볼 수 있는 주석 코드 있음 ⭐️
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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


// // ⭐️ TEST CODE: 아래처럼 UI만 보고 싶을 때 위에 기존거 주석 처리 하고 ✅
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const _App());
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
//       home: SecondOnboardingScreen(), // 여기 원하는 스크린 대입 ✅
//     );
//   }
// }




import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/layout/default_layout.dart';

class FirstOnboardingScreen extends ConsumerWidget {
  static String get routeName => 'onboarding1';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: Center(
        child: Text('First Onboarding Screen'),
      ),
    );
  }
}

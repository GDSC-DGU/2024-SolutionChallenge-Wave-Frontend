import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../layout/default_layout.dart';

class InitialScreen extends ConsumerWidget {
  static String get routeName => 'initial';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: Center(
        child: Text('Initial Screen'),
      ),
    );
  }
}

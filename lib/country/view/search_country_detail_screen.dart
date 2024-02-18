import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/layout/default_layout.dart';

class SearchCountryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'searchCountryDetail';
  final int id;
  const SearchCountryDetailScreen({required this.id, super.key});

  @override
  ConsumerState<SearchCountryDetailScreen> createState() =>
      _SearchCountryDetailScreenState();
}

class _SearchCountryDetailScreenState
    extends ConsumerState<SearchCountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: Column(
      children: [
        const Text('SearchCountryDetailScreen'),
      ],
    ));
  }
}

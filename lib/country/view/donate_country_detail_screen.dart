import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonateCountryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'donateCountryDetail';

  final int id;

  const DonateCountryDetailScreen({required this.id, super.key});

  @override
  ConsumerState<DonateCountryDetailScreen> createState() =>
      _DonateCountryDetailScreenState();
}

class _DonateCountryDetailScreenState extends ConsumerState<DonateCountryDetailScreen> {

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

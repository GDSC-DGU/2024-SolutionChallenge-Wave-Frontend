import 'package:flutter/material.dart';
import 'package:wave/common/layout/default_layout.dart';

class AttentionCountryScreen extends StatelessWidget {
  const AttentionCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Attention Waves',
      child: Column(
        children: [
          Text('AttentionCountryScreen'),
        ],
      ),
    );
  }
}

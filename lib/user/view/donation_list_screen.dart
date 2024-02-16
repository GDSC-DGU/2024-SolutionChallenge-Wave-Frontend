import 'package:flutter/material.dart';

class DonationListScreen extends StatefulWidget {
  const DonationListScreen({super.key});

  static const String routeName = '/donation-list';

  @override
  _DonationListScreenState createState() => _DonationListScreenState();
}

class _DonationListScreenState extends State<DonationListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donation list')),
      body: Column(
        children: [


        ],
      ),
    );
  }
}

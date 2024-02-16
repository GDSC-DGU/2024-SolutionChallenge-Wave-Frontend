import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationListScreen extends StatefulWidget {
  const DonationListScreen({super.key});

  static const String routeName = '/donation-list';

  @override
  _DonationListScreenState createState() => _DonationListScreenState();
}

class _DonationListScreenState extends State<DonationListScreen> {
  // Dummy data for the list of donations
  final List<Map<String, dynamic>> donations = [
    {
      'date': '1.27',
      'country': '🇺🇦 Ukraine',
      'time': '22:38',
      'waves': 130,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
    {
      'date': '1.27',
      'country': '🇵🇸 Palestine - Israel',
      'time': '17:29',
      'waves': 54,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation list'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 20), // Add spacing
          SizedBox(
            width: 165.0,
            height: 40.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFFE2E2E8).withOpacity(0.41),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  'Donated waves',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Non-scrollable content
                  Text(
                    '🌊 397',
                    style: TextStyle(
                      color: Color(0xFF247EF4),
                      fontWeight: FontWeight.w600,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    'Wave per 1USD / \$397.00',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16,),
          SizedBox(
            height: 12,
            child: Container(
              color: const Color(0xFFF1F1F7),
            ),
          ),
          const SizedBox(height: 40,),
          Expanded(
            child: ListView.separated(
                itemCount: donations.length,
                itemBuilder: (context, index) {
                  final donation = donations[index];
                  return Column(
                    children: [
                      const SizedBox(height: 8,),
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // 텍스트를 시작 지점(위)으로 정렬
                          children: [
                            const SizedBox(height: 4), // 상단 간격 조절을 위한 SizedBox
                            Text(
                              donation['date'],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        title: Row(
                          children: [
                            const SizedBox(width: 15), // title에 대한 간격
                            Text(
                              donation['country'],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(width: 15), // subtitle에 대한 간격
                            Expanded(
                              child: Text(
                                '${donation['time']} | donation',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🌊${donation['waves']}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              ' \$${donation['waves'].toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                      ), //각 리스트 사이의 간격
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 3),
              ),
            ),
          ],
        ),
      );
    }
  }
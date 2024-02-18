import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../loading/loading_screen.dart';

class DonationListScreen extends StatefulWidget {
  const DonationListScreen({Key? key}) : super(key: key);

  static const String routeName = '/donation-list';

  @override
  State<DonationListScreen> createState() => _DonationListScreenState();
}

class _DonationListScreenState extends State<DonationListScreen> {
  bool isLoading = true; // 로딩 상태를 관리하는 변수

  @override
  void initState() {
    super.initState();
    getDonationData();
  }

  //TODO: dummy data. 나중에 지우기
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

  // totalWave 및 기부 리스트 데이터 호출 API
  Future<Map<String, dynamic>> getDonationData() async {
    var url = Uri.parse('https://example.com/api/v1/users/donate'); //TODO: 서버 url 수정해야함
    var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json"
          // "Authorization": "Bearer $accessToken", // TODO: accessToken 가져와야 함
        }
    );

    await Future.delayed(const Duration(seconds: 1)); // 가상의 로딩 시간

    if (response.statusCode == 200) {
      isLoading = false;
      Map<String, dynamic> data = json.decode(response.body);
      // API 응답에서 "data" 키의 존재와 타입을 확인
      if (data.containsKey('data') && data['data'] is Map) {
        Map<String, dynamic> responseData = data['data'];
        // "donateList"의 존재와 리스트 타입을 확인
        if (responseData.containsKey('donateList') && responseData['donateList'] is List) {
          // 데이터가 예상한 형식으로 존재하는 경우
          return responseData;
        }
      }
      // 데이터 형식이 맞지 않는 경우 더미 데이터 반환
      return {
        "totalWave": 0,
        "donateList": donations,
      };
    } else {
      isLoading = false;
      // API 호출 실패 시 더미 데이터 반환
      return {
        "totalWave": 0,
        "donateList": donations,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation list'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: getDonationData(),
            builder: (context, snapshot) {
              if (isLoading) {
                return const LoadingScreen();
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
                // return const LoadingScreen();
              } else {
                // Assuming your user data includes 'nickname', 'totalWave', and 'donationCountryCnt'
                var totalWave = snapshot.data?['totalWave'] ?? 0;
                var donateList = snapshot.data?['donateList'] as List<dynamic>? ?? [];
                return Column(
                  children: [
                    const SizedBox(height: 20), // Add spacing
                    SizedBox(
                      width: 165.0,
                      height: 40.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E2E8).withOpacity(0.41),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Non-scrollable content
                            Text(
                              '🌊 $totalWave',
                              style: const TextStyle(
                                color: Color(0xFF247EF4),
                                fontWeight: FontWeight.w600,
                                fontSize: 48,
                              ),
                            ),
                            Text(
                              'Wave per 1USD / \$${totalWave.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.75),
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
                      child: donateList.isNotEmpty
                          ? ListView.separated(
                          itemCount: donateList.length,
                          itemBuilder: (context, index) {
                            final donation = donateList[index];
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
                                      const SizedBox(width: 15), // subtitle에 대한 간격
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
                        ) : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "There is no history of donation.\n Please give rise to 🌊Wave🌊 that will \n make a difference in the world!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  );
                }
              }
            )
        );
    }
  }
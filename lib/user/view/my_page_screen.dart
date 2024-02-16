import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../loading/loading_screen.dart';
import 'donation_list_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);
  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  Map<String, dynamic>? userInfo;
  bool isLoading = true; // 로딩 상태를 관리하는 변수

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  //회원 정보 받기 API 호출 함수
  Future<Map<String, dynamic>> getUserInfo() async {
    var url = Uri.parse('https://example.com/api/v1/users'); //TODO: 서버 url 수정해야함
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $accessToken", // TODO: accessToken 가져와야 함
    });
    await Future.delayed(const Duration(seconds: 1)); // 가상의 로딩 시간

    if (response.statusCode == 200) {
      isLoading = false; // 로딩 완료
      return json.decode(response.body)['data'];
    } else {
      //throw Exception('Failed to load user info');
      // API 호출 실패 시 더미 데이터 반환
      isLoading = false; // 로딩 완료
      return {
        "nickname": "DummyUser",
        "totalWave": 0,
        "donationCountryCnt": 0,
      };
    }
  }

  // 로그아웃 API 호출 함수
  Future<void> _logout() async {
    var url = Uri.parse('https://example.com/api/v1/auth/logout'); //TODO: 서버 url 수정해야함
    var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
         // "Authorization": "Bearer $accessToken", // TODO: accessToken 가져와야 함
        },
        body: {}
    );
    if (response.statusCode == 200) {
      // 로그아웃 처리 성공
      print('Logged out successfully');
    } else {
      // 오류 처리
      print('Failed to log out');
    }
  }

// 회원 탈퇴 API 호출 함수
  Future<void> _unsubscribe() async {
    var url = Uri.parse('https://example.com/api/v1/auth/sign-out'); //TODO: 서버 url 수정해야함
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer $accessToken", // TODO: accessToken 가져와야 함
        },
        body: {}
    );
    if (response.statusCode == 200) {
      // 회원 탈퇴 처리 성공
      print('Unsubscribed successfully');
    } else {
      // 오류 처리
      print('Failed to unsubscribe');
    }
  }

  // URL을 열기 위한 함수
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  // 사용자에게 확인을 요청하는 대화상자를 표시하는 함수
  Future<void> _showConfirmationDialog(BuildContext context, String title, String content, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF247EF4),
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: onConfirm,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF247EF4),
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = {
      'Donation list': () {
        // Donation List 스크린으로 이동
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DonationListScreen()));
      },
      'Terms and conditions': () => _launchURL('https://example.com/terms'),
      'Privacy policy': () => _launchURL('https://example.com/privacy'),
      'Unscribing membership': () => _showConfirmationDialog(
        context,
        'Are you sure you want to leave?',
        'All your donation lists will disappear. Would that be okay with you?',
        _unsubscribe,
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mypage', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (isLoading) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
            // return const LoadingScreen();
          } else {
            // Assuming your user data includes 'nickname', 'totalWave', and 'donationCountryCnt'
            var userData = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Donation Profile',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF247EF4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${userData['nickname']}', // 안전하게 데이터에 접근
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () => _showConfirmationDialog(
                                context,
                                'Do you want to logout?',
                                'You will be returned to the login screen.',
                                _logout,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white, width: 1.2),
                                minimumSize: const Size(80, 30),
                              ),
                              child: const Text('Log out', style: TextStyle(color: Colors.white, fontSize: 10)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF242424), // 내부 박스 색상 변경
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: buildInfoSection(userData['totalWave'], userData['donationCountryCnt']),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...['Donation list', 'Terms and conditions', 'Privacy policy', 'Unscribing membership']
                      .map(
                        (title) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(26, 10, 10, 10),
                        child: ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: actions[title]!,
                        ),
                      ),
                    ),
                  ).toList(),
                ],
              ),
            );
          }
        }
      )
    );
  }

  Widget buildInfoSection(int totalWave, int donationCountryCnt) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildInfoText('🌊 $totalWave', 'Delivered waves', 'Wave per 1USD / ${totalWave.toStringAsFixed(2)}'),
            const VerticalDivider(color: Colors.white),
            buildInfoText('🌍 $donationCountryCnt', 'Protected countries', ''),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(String value, String label, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white)),
        Text(description, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w300, color: Colors.white)),
        const SizedBox(height: 10),
      ],
    );
  }
}
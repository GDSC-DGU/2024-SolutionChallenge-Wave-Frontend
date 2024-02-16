import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  void _openWebPage(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to leave?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('All your donation lists will disappear.'),
                Text('Would that be okay with you?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                // Add your leaving logic here
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mypage',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Donation Profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500, // Adjust font weight here
                color: Colors.black,
              ),
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
                      child: const Text(
                        'Emma Smith',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // 로그아웃 로직
                      },
                      child: const Text('Log out', style: TextStyle(color: Colors.white, fontSize: 10,)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 1.2), // Set border thickness here
                        minimumSize: const Size(80, 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424), // 내부 박스 색상 변경
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: buildInfoSection(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ...['Donation list', 'Terms and conditions', 'Privacy policy', 'Unscribing membership']
              .map((title) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 10, 10, 10), // Add padding here
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500, // Adjust font weight here
                    color: Colors.black.withOpacity(0.9), // Adjust text opacity here
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // 해당 페이지로 이동 로직
                },
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0), // 내부 여백 추가
      child: IntrinsicHeight(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoText('🌊 397', 'Delivered waves', 'Wave per 1USD / 397.00'),
              const VerticalDivider(color: Colors.white),
              buildInfoText('🌍 43', 'Protected countries', ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoText(String value, String label, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

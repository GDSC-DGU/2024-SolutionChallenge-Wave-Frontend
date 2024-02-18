import 'package:flutter/material.dart';

class DonationListTile extends StatelessWidget {
  final Map<String, dynamic> donation;

  const DonationListTile({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Divider(color: Colors.black.withOpacity(0.1)),
      ],
    );
  }
}

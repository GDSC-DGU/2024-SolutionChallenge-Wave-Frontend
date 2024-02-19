import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final String newsImage;
  final String newsTitle;
  final String newsUrl;
  final String date;

  const NewsCard({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsUrl,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(newsUrl))) {
          await launchUrl(Uri.parse(newsUrl));
        } else {
          // URL을 열 수 없을 때의 처리
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $newsUrl'),
            ),
          );
        }
      },
      child: Container(
        width: 330,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(newsImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 300, // 제목 너비 제한
                    child: Text(
                      newsTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // 최대 2줄까지만 표시
                    ),
                  ),
                  Text(
                    'Read more...',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


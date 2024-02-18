import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/model/donate_country_detail_model.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';
import '../model/donate_country_model.dart';

class DonateCountryCard extends StatelessWidget {
  final String category;
  final String mainTitle;
  final String subTitle;
  final Widget image;
  final int allWave;
  final int lastWave;
  final int casualties;
  final bool isDetail;
  final int? heroKey;
  final String? imageProducer;
  final List<Content>? contents;
  final String? detailImage;
  final String? detailImageTitle;
  final String? detailImageProducer;
  final List<News>? news;
  final int id;

  const DonateCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
    this.isDetail = false,
    this.heroKey,
    this.imageProducer,
    this.contents,
    this.detailImage,
    this.detailImageTitle,
    this.detailImageProducer,
    this.news,
    Key? key,
  }) : super(key: key);

  factory DonateCountryCard.fromModel({
    required DonateCountryModel model,
    bool isDetail = false,
  }) {
    return DonateCountryCard(
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      // image: Image.network(
      //   model.image,
      //   fit: BoxFit.cover,
      // ),
      /// Test Image
      image: Image.asset(
        'assets/images/testImg.png',
        fit: BoxFit.cover,
      ),
      allWave: model.allWave,
      lastWave: model.lastWave,
      casualties: model.casualties,
      isDetail: isDetail,
      heroKey: model.id,
      imageProducer:
          model is DonateCountryDetailModel ? model.imageProducer : null,
      contents: model is DonateCountryDetailModel ? model.contents : null,
      detailImage: model is DonateCountryDetailModel ? model.detailImage : null,
      detailImageTitle:
          model is DonateCountryDetailModel ? model.detailImageTitle : null,
      detailImageProducer:
          model is DonateCountryDetailModel ? model.detailImageProducer : null,
      news: model is DonateCountryDetailModel ? model.news : null,
      id: model.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // 카드의 배경색을 설정합니다.
        borderRadius: BorderRadius.circular(12.0), // 카드의 모서리를 둥글게 처리합니다.
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              if (heroKey != null)
                Hero(
                  tag: ObjectKey(heroKey),
                  child: ClipRRect(
                    borderRadius: isDetail
                        ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                        : const BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                    child: image,
                  ),
                ),
              if (heroKey == null)
                ClipRRect(
                  borderRadius: isDetail
                      ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                      : const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    child: image,
                  ),
                ),
              Positioned(
                child: CategoryButton(category: category),
              ),
              Positioned(
                bottom: 8,
                left: 18,
                right: 8,
                child: Text(
                  "$mainTitle\n$subTitle",
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DonateCardRow(
              allWave: allWave,
              lastWave: lastWave,
              casualties: casualties,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10,
            ),
            child: ForwardDetailButton(
              buttonName: 'Sending Waves',
              onPressed: () {
                // Navigator를 사용해 상세 화면으로 이동
                // 여기서는 `id`를 DonateCountryCard가 받은 `id` 프로퍼티를 사용
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DonateCountryDetailScreen(id: id),
                //   ),
                // );

                print('kiki');
                context.pushNamed(DonateCountryDetailScreen.routeName,
                    pathParameters: {
                      'id': id.toString(),
                    });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DonateCountryDetailScreen(id: id),
                //   ),
                // );
              },
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

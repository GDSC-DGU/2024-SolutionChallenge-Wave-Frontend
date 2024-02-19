import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/donatet_button.dart';
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
      image: Image.network(
        model.image,
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
        color: Colors.white,
        borderRadius: isDetail ==  true ? BorderRadius.zero : const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: isDetail ==  true ? Colors.transparent : Colors.grey.withOpacity(0.5),
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
              if (heroKey != null) // heroKey != null => detail이 아닌 경우(지도에서 클릭시랑 2번째 탭화면)
                Hero(
                  tag: ObjectKey(heroKey),
                  child: ClipRRect(
                    borderRadius: isDetail
                        ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                        : const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                    child: image,
                  ),
                ),
              if (heroKey == null)
                ClipRRect(
                  borderRadius: isDetail
                      ? BorderRadius.zero // 상세 페이지에서는 모든 모서리를 직각으로
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    child: image,
                  ),
                ),
              if (heroKey == null) // heroKey가 null => detail인 경우(컬러 카테고리 보여줄 필요 없음)
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
                      fontSize: 18.0,
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
          if (!isDetail)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26.0,
              vertical: 10,
            ),
            child: ForwardDetailButton(
              buttonName: 'Sending Waves',
              onPressed: () {
                print('kiki');
                context.pushNamed(DonateCountryDetailScreen.routeName,
                    pathParameters: {
                      'id': id.toString(),
                    });
              },
            ),
          ),
          if(isDetail)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
                  child: Container(
                    width: 50, // 너비 50
                    height: 50, // 높이 50
                    decoration: BoxDecoration(
                      color: Color(0xFFE2E2E8), // SVG 배경색
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도
                          spreadRadius: 5, // 그림자 범위
                          blurRadius: 7, // 그림자 퍼짐 정도
                          offset: Offset(0, 3), // 그림자 위치
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글게 처리
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // 내부 여백
                      child: SvgPicture.asset(
                        'assets/icons/share.svg', // SVG 이미지 경로. assets 디렉토리에 위치해야 합니다.
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DonateButton(buttonName: 'Donate', onPressed: () {
                      // 버튼 클릭 시 수행할 작업
                    }),
                  ),
                ),
              ],
            ),
         if(isDetail)
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 10),
             child: Divider(
               color: BUTTON_BACKGROUND_COLOR,
               thickness: 1.5,
             ),
           ),
        ],
      ),
    );
  }
}

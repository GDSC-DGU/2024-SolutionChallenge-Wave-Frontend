import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/donate_button.dart';
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
      height: isDetail ==  true ? 500 : 360,
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
                bottom: 20,
                left: 21,
                right: 8,
                child: Text(
                  "$mainTitle\n$subTitle",
                  style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.9)),
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
                  padding: const EdgeInsets.fromLTRB(15, 6, 0, 6),
                  child: Container(
                    width: 60, // 너비 60
                    height: 60, // 높이 60
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // 모서리 둥글게 처리
                      image: const DecorationImage(
                        image: AssetImage('assets/icons/share.png'), // PNG 이미지 경로
                        fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        // 버튼 클릭 시 수행할 작업
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // 버튼 내부에 다른 위젯을 추가하고 싶다면 여기에 추가
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DonateButton(
                      buttonName: 'Donate',
                      onPressed: () {
                        // 버튼 클릭 시 수행할 작업
                      },
                      width: 270.0, // 버튼 너비를 200.0으로 설정
                      height: 60.0, // 버튼 높이를 50.0으로 설정
                    ),
                  ),
                ),
              ],
            ),
         if(isDetail)
           const Padding(
             padding: EdgeInsets.symmetric(vertical: 10),
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

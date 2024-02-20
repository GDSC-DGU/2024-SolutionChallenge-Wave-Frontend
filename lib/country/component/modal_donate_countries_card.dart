import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/donate_card_row.dart';
import 'package:wave/country/component/donate_button.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/model/donate_country_detail_model.dart';
import 'package:wave/country/view/donate_country_detail_screen.dart';
import 'package:wave/map/view/wave_select_screen.dart';
import '../model/donate_country_model.dart';

class ModalDonateCountryCard extends StatelessWidget {
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
  final String country;

  const ModalDonateCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.allWave,
    required this.lastWave,
    required this.casualties,
    required this.id,
    required this.country,
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

  factory ModalDonateCountryCard.fromModel({
    required DonateCountryModel model,
    bool isDetail = false,
  }) {
    return ModalDonateCountryCard(
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
      country: model.country,
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
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // 모서리를 15px 둥글게
        color: Colors.white, // 여기에 배경색을 설정
        // 필요하다면 여기에 boxShadow 등 다른 디자인 속성을 추가할 수 있습니다.
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
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: image,

                    ),

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
                width: 240, // 너비를 240으로 지정
                height: 44, // 높이를 50으로 지정
                isSearch: true,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaveSelectScreen(selectedCountry: country),
                          ),
                        );
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

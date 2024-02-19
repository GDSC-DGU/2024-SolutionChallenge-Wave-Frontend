import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/forward_detail_button.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/view/search_country_detail_screen.dart';

class SearchCountryCard extends StatelessWidget {
  final String category;
  final String mainTitle;
  final String subTitle;
  final Widget image;
  final int views;
  final bool isDetail;
  final int? heroKey;
  final String? imageProducer;
  final List<Content>? contents;
  final String? detailImage;
  final String? detailImageTitle;
  final String? detailImageProducer;
  final List<News>? news;
  final int id;

  const SearchCountryCard({
    required this.category,
    required this.mainTitle,
    required this.subTitle,
    required this.image,
    required this.views,
    this.isDetail = false,
    this.heroKey,
    this.imageProducer,
    this.contents,
    this.detailImage,
    this.detailImageTitle,
    this.detailImageProducer,
    this.news,
    required this.id,
    Key? key,
  }) : super(key: key);

  factory SearchCountryCard.fromModel({
    required SearchCountryModel model,
    bool isDetail = false,
  }) {
    return SearchCountryCard(
      id: model.id,
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: Image.network(
        model.image,
        fit: BoxFit.cover,
      ),
      views: model.views,
      isDetail: isDetail,
      heroKey: model.id,
      imageProducer:
          model is SearchCountryDetailModel ? model.imageProducer : null,
      contents: model is SearchCountryDetailModel ? model.contents : null,
      detailImage: model is SearchCountryDetailModel ? model.detailImage : null,
      detailImageTitle:
          model is SearchCountryDetailModel ? model.detailImageTitle : null,
      detailImageProducer:
          model is SearchCountryDetailModel ? model.detailImageProducer : null,
      news: model is SearchCountryDetailModel ? model.news : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
              if (heroKey != null)
                Hero(
                  tag: ObjectKey(heroKey!),
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
                      : BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                  child: Container(
                    height: 130,
                    width: 300,
                    child: image,
                  ),
                ),
              if (heroKey == null) // heroKey가 null => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  child: CategoryButton(category: category),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mainTitle,
                        style: TextStyle(
                          fontSize: 14.7,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter, // 기본값이므로, 필요에 따라 조정할 수 있습니다.
                      child: Padding(
                        padding: EdgeInsets.only(top: 2), // SvgPicture.asset을 위로 조금 이동
                        child: SvgPicture.asset('assets/icons/view.svg', width: 10, height: 10),
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      views.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF747474),
                      ), // View 카운트 글꼴 크기
                    ),
                  ],
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 14.7,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.9),
                  ), // 조절된 subTitle 글꼴 크기
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ForwardDetailButton(
              buttonName: 'Learn their pain',
              onPressed: () {
                context.pushNamed(SearchCountryDetailScreen.routeName,pathParameters: {
                  'id': id.toString(),
                });
              },
              width: 250,
              height: 55,
              isSearch: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Divider(
              color: BUTTON_BACKGROUND_COLOR,
              height: 1.5,
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

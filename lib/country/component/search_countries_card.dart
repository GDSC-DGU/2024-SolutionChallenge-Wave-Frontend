import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/country/component/category_button.dart';
import 'package:wave/country/component/country_category_button.dart';
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
  final String country;

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
    required this.country,
    Key? key,
  }) : super(key: key);

  factory SearchCountryCard.fromModel({
    required SearchCountryModel model,
    bool isDetail = false,
  }) {
    return SearchCountryCard(
      country: model.country,
      id: model.id,
      category: model.category,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      image: Image.network(
        model.image,
        width: double.infinity,
        height: isDetail ? 300 : 145,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null && isDetail == false) {
            return SizedBox(
              child: child,
              height: 145,
            ); // 로딩 완료
          }
          else if(loadingProgress != null && isDetail == true){
            return SizedBox(
              height: isDetail ? 300 : 145,
            );
          }
          else if (loadingProgress == null && isDetail == true) {
            return SizedBox(child: child,); // 로딩 완료
          }
          return const Center(
            child: SizedBox(
              height: 145,
            ),
          );
        },
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
        borderRadius: isDetail == true
            ? BorderRadius.zero
            : const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: isDetail == true
                ? Colors.transparent
                : Colors.grey.withOpacity(0.5),
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
                        ? BorderRadius.zero
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
                      ? BorderRadius.zero
                      : BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: image,
                ),
              if (heroKey !=
                  null && (isDetail == false)) // heroKey가 null => detail인 경우(컬러 카테고리 보여줄 필요 없음)
                Positioned(
                  child: CountryCategoryButton(
                    category: category,
                    countryName: country,
                  ),
                ),
              if (isDetail)
                Positioned(
                  bottom: 20,
                  left: 21,
                  right: 8,
                  child: Text(
                    "$mainTitle\n$subTitle",
                    style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.9)),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // isDetail이 false이거나 이미지 위에 겹쳐지지 않아야 하는 경우
                if (!isDetail)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mainTitle,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(
                            'assets/icons/view.svg',
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        views.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                        ),
                      ),
                    ],
                  ),
                if (!isDetail)
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
              ],
            ),
          ),
          if (!isDetail)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: isDetail
                  ? SizedBox.shrink()
                  : ForwardDetailButton(
                buttonName: 'Learn their pain',
                onPressed: () {
                  context.pushNamed(
                    SearchCountryDetailScreen.routeName,
                    pathParameters: {'id': id.toString()},
                  );
                },
                width: 250,
                height: 45,
                isSearch: true,
              ),
            ),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/search_countries_card.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:wave/country/provider/search_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';

import 'package:skeletons/skeletons.dart';

import '../model/search_country_detail_model.dart';

class SearchCountryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'searchCountryDetail';

  final int id;

  const SearchCountryDetailScreen({required this.id, super.key});

  @override
  ConsumerState<SearchCountryDetailScreen> createState() =>
      _SearchCountryDetailScreenState();
}

class _SearchCountryDetailScreenState
    extends ConsumerState<SearchCountryDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    print('written id : ${widget.id}');

    super.initState();
    Future.microtask(() => ref
        .read(searchNotifierProvider.notifier)
        .fetchSearchCountryDetail(widget.id.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.watch(searchNotifierProvider);
    final searchCountryModel = searchNotifier.searchCountry; // 기존 상태
    final searchCountryDetailModel =
        searchNotifier.searchCountryDetail; // 상세 정보

    // 로딩 중 또는 데이터 없음 처리
    if (searchCountryModel == null) {
      print('Please wait for loading');
      return const LoadingScreen(); // 기본 정보 로딩 중 처리
    }

    return DefaultLayout(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: controller,
              slivers: [
                renderTop(
                  model: searchCountryModel, // 기존 모델 사용
                ),
                // 상세 정보 로딩 상태 처리
                if (searchCountryDetailModel == null) renderLoading(),
                // 상세 정보가 로드되었다면, 상세 정보 UI 구성
                if (searchCountryDetailModel != null)
                  renderDetail(model: searchCountryDetailModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding renderDetail({
    required SearchCountryDetailModel model,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // index를 2로 나눈 몫을 사용하여 contents 리스트의 인덱스를 계산합니다.
            // 이렇게 함으로써, 각 contents 객체에 대해 두 개의 위젯(타이틀과 컨텐츠)을 생성합니다.
            int itemIndex = index ~/ 2;

            // 홀수 인덱스의 경우 title, 짝수 인덱스의 경우 content를 표시합니다.
            bool isTitle = index % 2 == 0;
            Content content = model.contents[itemIndex];

            if (isTitle) {
              // 타이틀 표시
              return Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 10.0), // 타이틀 위아래 패딩
                child: Text(
                  content.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              // 컨텐츠 표시
              return Padding(
                padding: const EdgeInsets.only(bottom: 30.0), // 컨텐츠 아래 패딩
                child: Text(
                  content.content,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              );
            }
          },
          // contents 리스트의 길이의 2배만큼 위젯을 생성합니다.
          // contents 객체당 타이틀과 컨텐츠 위젯이 하나씩 생성되므로, 총 위젯 수는 contents 객체 수의 2배입니다.
          childCount: model.contents.length * 2,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required SearchCountryModel model,
  }) {
    return SliverToBoxAdapter(
      child: SearchCountryCard.fromModel(
        model: model, // 기존에 전달받은 모델 데이터 사용
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

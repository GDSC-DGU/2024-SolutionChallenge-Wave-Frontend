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
    Future.microtask(() =>
        ref.read(searchNotifierProvider.notifier).fetchSearchCountryDetail(widget.id.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.watch(searchNotifierProvider);
    final searchCountryModel = searchNotifier.searchCountry; // 기존 상태
    final searchCountryDetailModel = searchNotifier.searchCountryDetail; // 상세 정보

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
                if (searchCountryDetailModel != null) renderDetail(model: searchCountryDetailModel),
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
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                model.detailImageTitle, ///테스트 테스트
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required SearchCountryModel model,
  }) {
    return  SliverToBoxAdapter(
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

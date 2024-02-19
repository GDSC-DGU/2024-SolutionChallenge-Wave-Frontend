import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/model/donate_country_detail_response.dart';
import 'package:wave/country/model/donate_country_model.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';

import '../model/donate_country_detail_model.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wave/country/component/back_button.dart';
import 'package:wave/country/component/country_detail_image.dart';
import 'package:wave/country/component/custom_divider.dart';

class DonateCountryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'donateCountryDetail';

  final int id;

  const DonateCountryDetailScreen({required this.id, super.key});

  @override
  ConsumerState<DonateCountryDetailScreen> createState() =>
      _DonateCountryDetailScreenState();
}

class _DonateCountryDetailScreenState extends ConsumerState<DonateCountryDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  Color _iconColor = Colors.white; // 초기 아이콘 색상은 흰색으로 설정

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener); // 스크롤 리스너 등록

    Future.microtask(() =>
        ref.read(donateNotifierProvider.notifier).fetchDonateCountryDetail(widget.id));
  }

  void _scrollListener() {
    const double threshold = 80; // 스크롤 임계값
    if (_scrollController.offset >= threshold) {
      if (_iconColor != Colors.black) {
        setState(() {
          _iconColor = Colors.black; // 스크롤 위치에 따라 아이콘 색상을 검정색으로 변경
        });
      }
    } else {
      if (_iconColor != Colors.white) {
        setState(() {
          _iconColor = Colors.white; // 스크롤 위치가 임계값 미만이면 아이콘 색상을 흰색으로 변경
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener); // 리스너 제거
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final donateNotifier = ref.watch(donateNotifierProvider);
    final donateCountryModel = donateNotifier.donateCountry; // 기존 상태
    final donateCountryDetailModel =
        donateNotifier.donateCountryDetail; // 상세 정보

    // 로딩 중 또는 데이터 없음 처리
    if (donateCountryModel == null) {
      print('Please wait for loading');
      return const LoadingScreen(); // 기본 정보 로딩 중 처리
    }

    return DefaultLayout(
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController, // 여기에 _scrollController 할당
              slivers: [
                renderTop(
                  model: donateCountryModel, // 기존 모델 사용
                ),
               // 상세 정보 로딩 상태 처리
                if (donateCountryDetailModel == null) renderLoading(),
                // 상세 정보가 로드되었다면, 상세 정보 UI 구성
                if (donateCountryDetailModel != null)
                  renderDetail(model: donateCountryDetailModel),
                if (donateCountryDetailModel != null)
                  renderCountryDetailImage(model: donateCountryDetailModel),
                const CustomDividerSliver(),
              ],
            ),
            // 뒤로가기 버튼
            CustomBackButton(
              iconColor: _iconColor, // 동적으로 변하는 아이콘 색상
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }

  SliverPadding renderDetail({
    required DonateCountryDetailModel model,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // contents 리스트의 길이의 2배 만큼 아이템을 생성합니다.
            // 타이틀과 컨텐츠를 번갈아가며 표시하기 위해 index를 2로 나누어 사용합니다.
            final contentIndex = index ~/ 2;
            final isTitle = index % 2 == 0;
            final content = model.contents[contentIndex];

            // 타이틀 아이템
            if (isTitle) {
              return Padding(
                padding: EdgeInsets.only(bottom: 30), // 타이틀과 내용 사이의 간격
                child: Text(
                  content.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            // 내용 아이템
            else {
              // 마지막 내용 아이템과 다음 Content 객체 사이의 간격을 조정
              final bottomPadding =
                  contentIndex < model.contents.length - 1 ? 40.0 : 0.0;
              return Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Text(
                  content.content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }
          },
          childCount: model.contents.length * 2
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required DonateCountryModel model,
  }) {
    return SliverToBoxAdapter(
      child: DonateCountryCard.fromModel(
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
  SliverToBoxAdapter renderCountryDetailImage({
    required DonateCountryDetailModel model,
  }) {
    // detailImage, detailImageTitle, detailImageProducer가 null이 아닌 경우에만 CountryDetailImage 컴포넌트를 렌더링합니다.
    if (model.detailImage != null && model.detailImageTitle != null && model.detailImageProducer != null) {
      return SliverToBoxAdapter(
        child: CountryDetailImage(
          imageUrl: model.detailImage!,
          title: model.detailImageTitle!,
          producer: model.detailImageProducer!,
        ),
      );
    } else {
      // 필요한 정보가 없는 경우 빈 컨테이너를 반환합니다.
      return SliverToBoxAdapter(child: Container());
    }
  }

}

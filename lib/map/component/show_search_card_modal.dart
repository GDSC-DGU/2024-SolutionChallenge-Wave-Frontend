import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/component/modal_search_countries_card.dart';
import 'package:wave/country/provider/search_country_provider.dart';

void showSearchCardModal(
    BuildContext context, int countryId, WidgetRef ref) async {
  // 상태 초기화
  bool isLoaded = false;
  // 데이터 로딩 시작
  await ref.read(searchNotifierProvider.notifier).fetchSearchCountry(countryId);
  // 데이터 로딩 완료 후 다이얼로그 표시
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.3), // 반투명한 흰색 배경
    builder: (BuildContext context) {
      // Provider를 통해 최신 상태를 구독
      return Consumer(
        builder: (context, ref, _) {
          final searchNotifier = ref.watch(searchNotifierProvider);
          // 데이터 로딩 여부 확인
          if (!isLoaded && searchNotifier.state == SearchState.loaded) {
            // 데이터 로딩 완료 상태로 변경
            isLoaded = true;
          }
          // 로딩 상태에 따라 UI 분기
          if (!isLoaded) {
            return const Center(
                child: CircularProgressIndicator(color: PRIMARY_BLUE_COLOR));
          } else {
            return Dialog(
              child: ModalSearchCountryCard.fromModel(
                model: searchNotifier.searchCountry!,
                isDetail: false, // 상세 페이지용 카드로 표시
              ),
            );
          }
        },
      );
    },
  );
}

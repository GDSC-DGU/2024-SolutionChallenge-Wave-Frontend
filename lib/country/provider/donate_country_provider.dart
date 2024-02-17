import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/model/common_response.dart';
import 'package:wave/country/repository/donate_country_repository.dart';
import '../model/donate_country_detail_model.dart';
import '../model/donate_country_model.dart';

/// 데이터(T? data), 에러(ErrorResponse? error), 로딩 상태(bool isLoading)를 포함하는 범용 상태 클래스
/// 어떤 유형의 데이터에 대해서도 로딩 중, 성공, 에러 상태를 표현할 수 있음

class AsyncState<T> {
  final T? data;
  final ErrorResponse? error;
  final bool isLoading;

  AsyncState({this.data, this.error, this.isLoading = false});
}

// Donation countries notifier
final donateCountriesNotifierProvider = StateNotifierProvider<
    DonateCountriesNotifier, AsyncState<List<DonateCountryModel>>>((ref) {
  return DonateCountriesNotifier(ref.watch(donateCountryRepositoryProvider));
});

// Donation country notifier
final donateCountryNotifierProvider = StateNotifierProvider.family<
    DonateCountryNotifier, AsyncState<DonateCountryModel>, int>((ref, id) {
  return DonateCountryNotifier(ref.watch(donateCountryRepositoryProvider), id);
});

// Donation country detail notifier
final donateCountryDetailNotifierProvider = StateNotifierProvider.family<
    DonateCountryDetailNotifier,
    AsyncState<DonateCountryDetailModel>,
    int>((ref, id) {
  return DonateCountryDetailNotifier(
      ref.watch(donateCountryRepositoryProvider), id);
});

// Generic handling for async operations
Future<void> handleAsyncOperation<T>(
  StateNotifier<AsyncState<T>> notifier,
  Future<T> Function() operation,
) async {
  notifier.state = AsyncState<T>(isLoading: true);
  try {
    final result = await operation();
    notifier.state = AsyncState<T>(data: result);
  } catch (error) {
    notifier.state = AsyncState<T>(error: ErrorResponse(code: -1, message: error.toString()));
  }
}

class DonateCountriesNotifier
    extends StateNotifier<AsyncState<List<DonateCountryModel>>> {
  final DonateCountryRepository _repository;

  DonateCountriesNotifier(this._repository)
      : super(AsyncState(isLoading: true)) {
    _fetchDonateCountries();
  }

  Future<void> _fetchDonateCountries() async {
    await handleAsyncOperation<List<DonateCountryModel>>(
      this,
      () async {
        final response = await _repository.getDonateCountries();
        // API 응답에서 data 필드가 null이 아니고 List<DonateCountryModel> 타입으로 안전하게 변환할 수 있는지 확인합니다.
        if (response.success && response.data != null) {
          // List<dynamic>에서 List<DonateCountryModel>로 명시적으로 변환
          final countries = response.data!
              .map(
                  (e) => DonateCountryModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return countries;
        } else {
          // 변환할 수 없는 경우 빈 리스트를 반환합니다.
          return <DonateCountryModel>[];
        }
      },
    );
  }
}

class DonateCountryNotifier
    extends StateNotifier<AsyncState<DonateCountryModel>> {
  final DonateCountryRepository _repository;
  final int _id;

  DonateCountryNotifier(this._repository, this._id)
      : super(AsyncState(isLoading: true)) {
    _fetchDonateCountry();
  }

  Future<void> _fetchDonateCountry() async {
    await handleAsyncOperation(
        this, () async => (await _repository.getDonateCountry(id: _id)));
  }
}

class DonateCountryDetailNotifier
    extends StateNotifier<AsyncState<DonateCountryDetailModel>> {
  final DonateCountryRepository _repository;
  final int _id;

  DonateCountryDetailNotifier(this._repository, this._id)
      : super(AsyncState(isLoading: true)) {
    _fetchDonateCountryDetail();
  }

  Future<void> _fetchDonateCountryDetail() async {
    await handleAsyncOperation(
        this, () async => (await _repository.getDonateCountryDetail(id: _id)));
  }
}

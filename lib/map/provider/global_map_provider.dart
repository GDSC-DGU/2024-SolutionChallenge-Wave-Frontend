// important_countries_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/map/model/important_countries_model.dart';
import 'package:wave/map/repository/global_map_repository.dart';
import 'package:wave/map/model/important_countries_response.dart';

final importantCountriesProvider = StateNotifierProvider<ImportantCountriesNotifier, ImportantCountriesState>(
      (ref) => ImportantCountriesNotifier(ref.read(globalMapRepositoryProvider)),
);

class ImportantCountriesNotifier extends StateNotifier<ImportantCountriesState> {
  final GlobalMapRepository _repository;

  ImportantCountriesNotifier(this._repository) : super(ImportantCountriesLoading()) {
    _fetchImportantCountries();
  }

  Future<void> _fetchImportantCountries() async {
    try {
      final response = await _repository.getImportantCountries();
      if (response.success && response.data != null) {
        state = ImportantCountriesLoaded(response.data!);
      } else {
        state = ImportantCountriesError("Failed to load countries");
      }
    } catch (e) {
      state = ImportantCountriesError(e.toString());
    }
  }
}

// 상태 정의
abstract class ImportantCountriesState {}
class ImportantCountriesLoading extends ImportantCountriesState {}
class ImportantCountriesLoaded extends ImportantCountriesState {
  final ImportantCountriesModel data;
  ImportantCountriesLoaded(this.data);
}
class ImportantCountriesError extends ImportantCountriesState {
  final String message;
  ImportantCountriesError(this.message);
}

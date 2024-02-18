// important_countries_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/map/model/important_countries_model.dart';
import 'package:wave/map/repository/global_map_repository.dart';
import 'package:wave/map/model/important_countries_response.dart';

final importantCountriesProvider = StateNotifierProvider<ImportantCountriesNotifier, ImportantCountriesBase>(
      (ref) => ImportantCountriesNotifier(ref.read(globalMapRepositoryProvider)),
);

class ImportantCountriesNotifier extends StateNotifier<ImportantCountriesBase> {
  final GlobalMapRepository _repository;

  ImportantCountriesNotifier(this._repository) : super(ImportantCountriesLoading()) {

    _fetchImportantCountries();
  }

  Future<void> _fetchImportantCountries() async {
    print('kiki');
    try {
      final response = await _repository.getImportantCountries();
      print('why');
      if (response.success && response.data != null) {
        print('nuya');
        state = response.data!;
      } else {
        state = ImportantCountriesError(message: 'important countries data loading error in else in provider folder');
      }
    } catch (e) {
      state = ImportantCountriesError(message: 'important countries data loading error in catch provider folder');
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/country/model/search_countries_data.dart';
import 'package:wave/country/repository/search_country_repository.dart';
import 'package:wave/country/model/search_countries_response.dart';
import 'package:wave/country/model/search_country_response.dart';
import 'package:wave/country/model/search_country_detail_model.dart';
import 'package:wave/country/model/search_country_model.dart';
import 'package:collection/collection.dart';
enum SearchState { idle, loading, loaded, error }

final searchNotifierProvider = ChangeNotifierProvider((ref) => SearchNotifier(ref.watch(searchCountryRepositoryProvider)));

class SearchNotifier extends ChangeNotifier {
  final SearchCountryRepository _repository;
  SearchCountryModel? searchCountry;
  SearchCountryDetailModel? searchCountryDetail;
  SearchCountriesData? searchCountriesData;
  SearchState state = SearchState.idle;
  String? errorMessage;

  SearchNotifier(this._repository);

  List<SearchCountryModel> getEmergencyCountries() {
    return searchCountriesData?.emergency ?? [];
  }

  List<SearchCountryModel> getAlertCountries() {
    return searchCountriesData?.alert ?? [];
  }

  List<SearchCountryModel> getCautionCountries() {
    return searchCountriesData?.caution ?? [];
  }


  void _setState(SearchState state) {
    this.state = state;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    _setState(SearchState.error);
  }

  Future<void> fetchSearchCountries() async {
    _setState(SearchState.loading);
    try {
      final response = await _repository.getSearchCountries();
      if (response.success && response.data != null) {
        print('SearchState.loaded: ${state.index}');
        searchCountriesData = response.data;
        _setState(SearchState.loaded);
        print('searchCountriesData: $searchCountriesData');
        print('SearchState.loaded1: ${state.index}');
      } else {
        _setError("Failed to load search countries data.");
      }
    } catch (error) {
      _setError("Error fetching search countries: $error");
    }
  }

  Future<void> fetchSearchCountry(int id) async {
    _setState(SearchState.loading);
    try {
      final response = await _repository.getSearchCountry(id: id);
      if (response.success && response.data != null) {
        searchCountry = response.data;
        _setState(SearchState.loaded);
        print('SearchState.loaded2: ${state.index}');
      } else {
        _setError("Failed to load search country data.");
      }
    } catch (error) {
      _setError("Error fetching search country: $error");
    }
  }

  Future<void> fetchSearchCountryDetail(int id) async {
    _setState(SearchState.loading);
    try {
      final response = await _repository.getSearchCountryDetail(id: id);
      if (response.success && response.data != null) {
        searchCountryDetail = response.data!;

        if(searchCountry!=null){
          print('걸렸다ㅎㅎ@@@');
          return;
        }

        searchCountry = searchCountriesData?.emergency?.firstWhereOrNull((country) => country.id == id) ??
            searchCountriesData?.alert?.firstWhereOrNull((country) => country.id == id) ??
            searchCountriesData?.caution?.firstWhereOrNull((country) => country.id == id);

        _setState(SearchState.loaded);
      } else {
        _setError("Failed to load search country detail.");
      }
    } catch (error) {
      _setError("Error fetching search country detail: $error");
    }
  }

}

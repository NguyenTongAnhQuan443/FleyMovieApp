import 'package:fleymovieapp/data_sources/kkphim/api_services_series_movie.dart';
import 'package:flutter/cupertino.dart';

import '../data_sources/kkphim/api_services_single_movie.dart';
import '../models/kkphim/movie.dart';

class HomeScreenViewModel extends ChangeNotifier {
  // Source Movie
  final List<String> sourceMovie = [
    'KK Phim',
    'Phim Mới',
    'Mọt Phim',
    'Chill Hay'
  ];

  // Source banner
  final List<String> imageBannerUrls = [
    'https://cinema.momocdn.net/img/51864595072123353-wEXCCYzbslBJoym4aeiIV2V7cGz.jpg',
    'https://static2.vieon.vn/vieplay-image/poster_v4/2022/08/25/0snqk97o_660x946-tiemcapheluat.jpg',
    'https://images2.thanhnien.vn/528068263637045248/2024/2/20/special-poster-2-mai-17084211313531000860296.jpg',
  ];

  List<String> getImageBannerUrls() {
    return imageBannerUrls;
  }

  List<String> getSourceMovie() {
    return sourceMovie;
  }

  // Fetch data single movie
  Movie? _singleMovie;

  Movie? get singleMovie => _singleMovie;

  Future<void> fetchSingleMovie(int page) async {
    ApiServicesSingleMovie apiService = ApiServicesSingleMovie(page);
    try {
      Movie movie = await apiService.fetchMovie();
      if (movie.data != null && movie.data!.items != null) {
        _singleMovie = movie;
      } else {
        _singleMovie = null;
      }
    } catch (e) {
      _singleMovie = null;
    }
    notifyListeners();
  }

  // Fetch data series movie
  Movie? _seriesMovie;

  Movie? get seriesMovie => _seriesMovie;

  Future<void> fetchSeriesMovie(int page) async {
    ApiServicesSeriesMovie apiService = ApiServicesSeriesMovie(page);
    try {
      Movie movie = await apiService.fetchMovie();
      if (movie.data != null && movie.data!.items != null) {
        _seriesMovie = movie;
      } else {
        _seriesMovie = null;
      }
    } catch (e) {
      _seriesMovie = null;
    }
    notifyListeners();
  }
}

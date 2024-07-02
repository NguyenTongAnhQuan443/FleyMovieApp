import 'package:flutter/cupertino.dart';
import '../data_sources/kkphim/api_services_series_movie.dart';
import '../data_sources/kkphim/api_services_single_movie.dart';
import '../models/kkphim/movie.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<String> sourceMovie = ['KK Phim', 'Phim Mới', 'Mọt Phim', 'Chill Hay'];
  final List<String> imageBannerUrls = [
    'https://cinema.momocdn.net/img/51864595072123353-wEXCCYzbslBJoym4aeiIV2V7cGz.jpg',
    'https://static2.vieon.vn/vieplay-image/poster_v4/2022/08/25/0snqk97o_660x946-tiemcapheluat.jpg',
    'https://images2.thanhnien.vn/528068263637045248/2024/2/20/special-poster-2-mai-17084211313531000860296.jpg',
  ];

  List<String> getImageBannerUrls() => imageBannerUrls;
  List<String> getSourceMovie() => sourceMovie;

  Movie? _singleMovie;
  Movie? _seriesMovie;
  bool _isLoading = false;

  Movie? get singleMovie => _singleMovie;
  Movie? get seriesMovie => _seriesMovie;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    await Future.wait([fetchSingleMovie(1), fetchSeriesMovie(1)]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSingleMovie(int page) async {
    ApiServicesSingleMovie apiService = ApiServicesSingleMovie(page);
    try {
      Movie movie = await apiService.fetchMovie();
      _singleMovie = movie.data?.items != null ? movie : null;
    } catch (e) {
      _singleMovie = null;
    }
  }

  Future<void> fetchSeriesMovie(int page) async {
    ApiServicesSeriesMovie apiService = ApiServicesSeriesMovie(page);
    try {
      Movie movie = await apiService.fetchMovie();
      _seriesMovie = movie.data?.items != null ? movie : null;
    } catch (e) {
      _seriesMovie = null;
    }
  }
}

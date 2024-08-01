import 'dart:io';
import 'package:fleymovieapp/models/kkphim/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<String> sourceMovie = [
    'KK Phim',
    'Phim Mới',
    'Mọt Phim',
    'Chill Hay'
  ];

  List<String> getSourceMovie() => sourceMovie;

  Movie? _newMovie;
  Movie? _singleMovie;
  Movie? _seriesMovie;
  Movie? _cartoonMovie;
  Movie? _tiviShows;
  bool _isLoading = false;

  Movie? get newMovie => _newMovie;

  Movie? get singleMovie => _singleMovie;

  Movie? get seriesMovie => _seriesMovie;

  Movie? get cartoonMovie => _cartoonMovie;

  Movie? get tiviShows => _tiviShows;

  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    try {
      _isLoading = true;
      notifyListeners();

      final result = await Future.wait([
        fetchMovie('danh-sach/phim-moi-cap-nhat', 1),
        fetchMovie('v1/api/danh-sach/phim-le', 1),
        fetchMovie('v1/api/danh-sach/phim-bo', 1),
        fetchMovie('v1/api/danh-sach/hoat-hinh', 1),
        fetchMovie('v1/api/danh-sach/tv-shows', 1)
      ]);

      _newMovie = result[0];
      _singleMovie = result[1];
      _seriesMovie = result[2];
      _cartoonMovie = result[3];
      _tiviShows = result[4];
    } catch (e) {
      _newMovie = null;
      _singleMovie = null;
      _seriesMovie = null;
      _cartoonMovie = null;
      _tiviShows = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Movie?> fetchMovie(String movieType, int page) async {
    try {
      final response = await http
          .get(Uri.parse('https://phimapi.com/$movieType?page=$page'));

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(json.jsonDecode(response.body));
        return movie.data?.items != null ? movie : null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

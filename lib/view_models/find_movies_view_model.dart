import 'package:fleymovieapp/models/kkphim/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';

class FindMoviesViewModel extends ChangeNotifier {
  final soureMovie = 'https://phimapi.com/v1/api/';
  Movie? _movie;
  bool _isLoading = false;
  List<Items> _moviesList = [];

  Movie? get movie => _movie;

  bool get isLoading => _isLoading;

  List<Items> get moviesList => _moviesList;

  Future<void> fetchMovies(String keyWord, {bool isLoadMore = false}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response =
          await http.get(Uri.parse('${soureMovie}tim-kiem?keyword=$keyWord'));

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(json.jsonDecode(response.body));
        if (movie.data?.items != null) {
          if (isLoadMore) {
            _moviesList.addAll(movie.data!.items!);
          } else {
            _moviesList = movie.data!.items!;
          }
          _movie = movie;
        } else {
          _movie = null;
        }
      } else {
        _movie = null;
      }
    } catch (e) {
      _movie = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoviesByCategory(String category,
      {bool isLoadMore = false}) async {
    // https://phimapi.com/v1/api/the-loai/kinh-di
    try {
      _isLoading = true;
      notifyListeners();

      final response =
          await http.get(Uri.parse('${soureMovie}the-loai/$category'));

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(json.jsonDecode(response.body));
        if (movie.data?.items != null) {
          if (isLoadMore) {
            _moviesList.addAll(movie.data!.items!);
          } else {
            _moviesList = movie.data!.items!;
          }
          _movie = movie;
        } else {
          _movie = null;
        }
      } else {
        _movie = null;
      }
    } catch (e) {
      _movie = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoviesByCountry(String country,
      {bool isLoadMore = false}) async {
    // https://phimapi.com/v1/api/quoc-gia/han-quoc
    try {
      _isLoading = true;
      notifyListeners();

      final response =
          await http.get(Uri.parse('${soureMovie}quoc-gia/$country'));

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(json.jsonDecode(response.body));
        if (movie.data?.items != null) {
          if (isLoadMore) {
            _moviesList.addAll(movie.data!.items!);
          } else {
            _moviesList = movie.data!.items!;
          }
          _movie = movie;
        } else {
          _movie = null;
        }
      } else {
        _movie = null;
      }
    } catch (e) {
      _movie = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

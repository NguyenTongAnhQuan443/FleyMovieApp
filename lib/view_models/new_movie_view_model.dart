import 'package:fleymovieapp/models/kkphim/new_movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';

class NewMovieViewModel extends ChangeNotifier {
  NewMovie? _newMovie;

  bool _isLoading = false;

  NewMovie? get newMovie => _newMovie;

  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    try {
      _isLoading = true;
      notifyListeners();

      final result = await Future.wait([
        fetchMovie('danh-sach/phim-moi-cap-nhat', 1),
      ]);

      _newMovie = result[0];
    } catch (e) {
      _newMovie = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<NewMovie?> fetchMovie(String movieType, int page) async {
    try {
      final response = await http
          .get(Uri.parse('https://phimapi.com/$movieType?page=$page'));

      if (response.statusCode == 200) {
        NewMovie movie = NewMovie.fromJson(json.jsonDecode(response.body));
        return movie.items != null ? movie : null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

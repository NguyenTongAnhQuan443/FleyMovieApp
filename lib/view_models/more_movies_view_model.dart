import 'package:fleymovieapp/models/kkphim/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';

class MoreMoviesViewModel extends ChangeNotifier {
  Movie? _movie;
  bool _isLoading = false;

  Movie? get movie => _movie;

  bool get isLoading => _isLoading;

  Future<void> fetchMovies(String movieType, int page) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(Uri.parse(
          'https://phimapi.com/v1/api/danh-sach/$movieType?page=$page'));

      if (response.statusCode == 200) {
        Movie movie = Movie.fromJson(json.jsonDecode(response.body));
        _movie = movie.data?.items != null ? movie : null;
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

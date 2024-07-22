import 'dart:io';

import 'package:fleymovieapp/models/kkphim/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';

class FindMoviesViewModel extends ChangeNotifier {
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

      final response = await http.get(
          Uri.parse('https://phimapi.com/v1/api/tim-kiem?keyword=$keyWord'));

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

  Future<bool> checkImageUrl(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == HttpStatus.ok) {
        final bytes = response.bodyBytes;
        return isImage(bytes);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool isImage(List<int> bytes) {
    if (bytes.length < 4) return false;
    return true;
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/kkphim/movie_details.dart';

class MovieDetailsScreenViewModel with ChangeNotifier {
  // var
  bool _isLoading = false;
  MovieDetails? _movieDetails;

  // Getter
  bool get isLoading => _isLoading;
  MovieDetails? get movieDetails => _movieDetails;

  Future<void> fetchMovieDetails(String slug) async {
    _isLoading = true;
    notifyListeners();

    final reponse = await http.get(Uri.parse('https://phimapi.com/phim/$slug'));
    _isLoading = false;

    if (reponse.statusCode == 200) {
      final jsonBody = reponse.body;
      if (jsonBody != null) {
        final jsonData = json.decode(jsonBody);
        _movieDetails = MovieDetails.fromJson(jsonData);
        notifyListeners();
      } else {
        throw Exception("Reponse body is null");
      }
    } else {
      throw Exception("Faild to load movie details");
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/kkphim/movie_details.dart';

class MovieDetailsScreenViewModel with ChangeNotifier {
  // Variables
  bool _isLoading = false;
  MovieDetails? _movieDetails;
  bool _isDisposed = false;

  // Getters
  bool get isLoading => _isLoading;
  MovieDetails? get movieDetails => _movieDetails;

  // Override dispose method
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
  void _safeNotifyListeners() {
    if(!_isDisposed){
      notifyListeners();
    }
  }

  // Fetch movie details
  Future<void> fetchMovieDetails(String slug) async {
    _isLoading = true;
    // notifyListeners();
    _safeNotifyListeners();
    try {
      final response = await http.get(Uri.parse('https://phimapi.com/phim/$slug'));
      _isLoading = false;

      if (response.statusCode == 200) {
        final jsonBody = response.body;
        if (jsonBody.isNotEmpty) {
          final jsonData = json.decode(jsonBody);
          _movieDetails = MovieDetails.fromJson(jsonData);
          // notifyListeners();
          _safeNotifyListeners();
        } else {
          throw Exception("Response body is empty");
        }
      } else {
        throw Exception("Failed to load movie details: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      _isLoading = false;
      // notifyListeners();
      _safeNotifyListeners();
    } catch (e) {
      _isLoading = false;
      // notifyListeners();
      _safeNotifyListeners();
    }
  }
}

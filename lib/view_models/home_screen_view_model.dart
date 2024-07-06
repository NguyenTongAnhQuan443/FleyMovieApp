import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:flutter/foundation.dart';
import '../../models/kkphim/movie.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final List<String> sourceMovie = [
    'KK Phim',
    'Phim Mới',
    'Mọt Phim',
    'Chill Hay'
  ];
  final List<String> imageBannerUrls = [
    'https://cinema.momocdn.net/img/51864595072123353-wEXCCYzbslBJoym4aeiIV2V7cGz.jpg',
    'https://static2.vieon.vn/vieplay-image/poster_v4/2022/08/25/0snqk97o_660x946-tiemcapheluat.jpg',
    'https://images2.thanhnien.vn/528068263637045248/2024/2/20/special-poster-2-mai-17084211313531000860296.jpg',
  ];

  List<String> getImageBannerUrls() => imageBannerUrls;

  List<String> getSourceMovie() => sourceMovie;

  Movie? _singleMovie;
  Movie? _seriesMovie;
  Movie? _cartoonMovie;
  Movie? _tiviShows;
  bool _isLoading = false;

  Movie? get singleMovie => _singleMovie;

  Movie? get seriesMovie => _seriesMovie;

  Movie? get cartoonMovie => _cartoonMovie;

  Movie? get tiviShows => _tiviShows;

  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    try {
      _isLoading = true;
      notifyListeners();
      _singleMovie = await _fetchMovie('phim-le', 1);
      _seriesMovie = await _fetchMovie('phim-bo', 1);
      _cartoonMovie = await _fetchMovie('hoat-hinh', 1);
      _tiviShows = await _fetchMovie('tv-shows', 1);
    } catch (e) {
      _singleMovie = null;
      _seriesMovie = null;
      _cartoonMovie = null;
      _tiviShows = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Movie?> _fetchMovie(String movieType, int page) async {
    try {
      final response = await http.get(Uri.parse('https://phimapi.com/v1/api/danh-sach/$movieType?page=$page'));

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

  Future<bool> checkImageUrl(String imageUrl) async {
    HttpClient client = HttpClient();
    try {
      HttpClientRequest request = await client.getUrl(Uri.parse(imageUrl));
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        List<int> bytes = await consolidateHttpClientResponseBytes(response);
        if (_isImage(bytes)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  bool _isImage(List<int> bytes) {
    if (bytes.length < 4) return false;
    return true;
  }
}

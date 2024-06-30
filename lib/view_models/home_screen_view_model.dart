import 'package:fleymovieapp/data_sources/kkphim/api_services_single_movie.dart';
import 'package:fleymovieapp/models/kkphim/single_movie.dart';
import 'package:flutter/cupertino.dart';

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

  List<String> getImageBannerUrls() {
    return imageBannerUrls;
  }

  List<String> getSourceMovie() {
    return sourceMovie;
  }

  //Fetch Data
  // SingleMovie? _singleMovie;
  //
  // SingleMovie? get singleMovie => _singleMovie;
  //
  // Future<void> fetchSingleMovie(int page) async {
  //   ApiServicesSingleMovie apiService = ApiServicesSingleMovie(page);
  //   try {
  //     SingleMovie singleMovie = await apiService.fetchMovie();
  //     _singleMovie = singleMovie;
  //   } catch (e) {
  //     print('Error: $e');
  //     _singleMovie = null;
  //   }
  //   notifyListeners(); // Notify các widget đã đăng ký để cập nhật lại
  // }

}

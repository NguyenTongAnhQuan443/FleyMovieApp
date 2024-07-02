import 'package:fleymovieapp/models/kkphim/single_movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import '../../models/kkphim/movie.dart';
import 'fetch_data_exception.dart';

class ApiServicesSeriesMovie {
  int page;

  ApiServicesSeriesMovie(this.page);

  Future<Movie> fetchMovie() async {
    final response = await http.get(Uri.parse('https://phimapi.com/v1/api/danh-sach/phim-bo?page=$page'));

    if (response.statusCode == 200) {
      return Movie.fromJson(json.jsonDecode(response.body));
    } else {
      throw FetchDataException("StatusCode: ${response.statusCode}, Error: ${response.reasonPhrase}");
    }
  }
}

import 'dart:convert';
import 'package:fleymovieapp/models/kkphim/single_movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ApiServicesSingleMovie {
  int page;

  ApiServicesSingleMovie(this.page);

  Future<SingleMovie> fetchMovie() async {
    final response = await http.get(Uri.parse('https://phimapi.com/v1/api/danh-sach/phim-le?page=$page'));

    if (response.statusCode == 200) {
      return SingleMovie.fromJson(json.jsonDecode(response.body));
    } else {
      throw FetchDataException("StatusCode: ${response.statusCode}, Error: ${response.reasonPhrase}");
    }
  }
}
class FetchDataException implements Exception {
  String cause;
  FetchDataException(this.cause);

  @override
  String toString() {
    return 'FetchDataException: $cause';
  }
}
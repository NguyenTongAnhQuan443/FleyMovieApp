class ApiUrlsMovieInfomationAndMovieList {
  String slugMovie;
  late final Uri API_CARTOON_LIST;

  ApiUrlsMovieInfomationAndMovieList(this.slugMovie) {
    API_CARTOON_LIST = Uri.parse('https://phimapi.com/phim/$slugMovie');
  }
}

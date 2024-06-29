class ApiUrlNewlyUpdatedMovie {
  int page;

  ApiUrlNewlyUpdatedMovie(this.page) {
    final Uri API_USER_LIST =
        Uri.parse('https://api.randomuser.me/?results=$page');
  }
}

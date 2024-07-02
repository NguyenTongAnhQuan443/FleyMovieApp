class FetchDataException implements Exception {
  String cause;
  FetchDataException(this.cause);

  @override
  String toString() {
    return 'FetchDataException: $cause';
  }
}
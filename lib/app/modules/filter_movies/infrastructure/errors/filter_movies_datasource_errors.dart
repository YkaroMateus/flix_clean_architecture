abstract class FilterMoviesDatasourceErrors implements Exception {
  final String message;

  FilterMoviesDatasourceErrors({required this.message});
}

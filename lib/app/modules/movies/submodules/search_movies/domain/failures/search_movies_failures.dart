import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class SearchMoviesFailures implements Failure {
  final String message;

  SearchMoviesFailures(this.message);
}

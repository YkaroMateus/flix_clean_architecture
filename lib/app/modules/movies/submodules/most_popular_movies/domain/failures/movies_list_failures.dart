import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class MoviesListFailures implements Failure {
  final String message;

  MoviesListFailures(this.message);
}

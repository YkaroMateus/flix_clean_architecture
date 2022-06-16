import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class MoviesByGenresFailures implements Failure {
  final String message;

  MoviesByGenresFailures(this.message);
}

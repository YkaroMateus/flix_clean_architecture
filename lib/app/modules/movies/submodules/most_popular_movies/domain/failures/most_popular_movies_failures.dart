import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class MostPopularMoviesFailures implements Failure {
  final String message;

  MostPopularMoviesFailures(this.message);
}

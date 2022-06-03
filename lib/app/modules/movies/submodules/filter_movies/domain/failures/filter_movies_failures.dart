import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class FilterMoviesFailures implements Failure {
  final String message;

  FilterMoviesFailures(this.message);
}

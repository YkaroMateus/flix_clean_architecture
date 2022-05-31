import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class MovieDetailsFailures implements Failure {
  final String message;

  MovieDetailsFailures(this.message);
}

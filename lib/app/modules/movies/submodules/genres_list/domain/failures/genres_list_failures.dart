import 'package:flix_clean_ark/app/core/errors/failure.dart';

abstract class GenresListFailures implements Failure {
  final String message;

  GenresListFailures(this.message);
}

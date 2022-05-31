import 'package:flix_clean_ark/app/modules/movie_details/domain/failures/movie_details_failures.dart';

class MovieDetailsFailure implements MovieDetailsFailures {
  final String message;

  MovieDetailsFailure({required this.message});
}

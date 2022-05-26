import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failures.dart';

class MostPopularMoviesFailure implements MostPopularMoviesFailures {
  final String message;

  MostPopularMoviesFailure({required this.message});
}

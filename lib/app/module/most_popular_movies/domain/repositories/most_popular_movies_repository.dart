import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';
import '../../../../core/errors/failure.dart';

abstract class MostPopularMoviesRepository {
  Future<Either<Failure, MostPopularMovies>> call();
}

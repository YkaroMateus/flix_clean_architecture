import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';

import '../repositories/most_popular_movies_repository.dart';

abstract class GetMostPopularMovies {
  Future<Either<Failure, MostPopularMovies>> call();
}

class GetMostPopularMoviesImplementation implements GetMostPopularMovies {
  final MostPopularMoviesRepository repository;

  GetMostPopularMoviesImplementation(this.repository);

  @override
  Future<Either<Failure, MostPopularMovies>> call() async {
    return await repository();
  }
}

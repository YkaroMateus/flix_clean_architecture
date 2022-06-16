import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../repositories/most_popular_movies_repository.dart';

abstract class GetMostPopularMovies {
  Future<Either<Failure, MoviesList>> call();
}

class GetMostPopularMoviesImplementation implements GetMostPopularMovies {
  final MostPopularMoviesRepository repository;

  GetMostPopularMoviesImplementation(this.repository);

  @override
  Future<Either<Failure, MoviesList>> call() async {
    return await repository();
  }
}

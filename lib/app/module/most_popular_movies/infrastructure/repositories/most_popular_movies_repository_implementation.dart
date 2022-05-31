import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/errors/most_popular_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/repositories/most_popular_movies_repository.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/datasource/most_popular_movie_datasource.dart';

import '../../../../core/errors/failure.dart';

class MostPopularMoviesRepositoryImplementation implements MostPopularMoviesRepository {
  final MostPopularMoviesDatasource datasource;

  MostPopularMoviesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, MostPopularMovies>> call() async {
    try {
      return Right(await datasource());
    } on MostPopularMoviesDatasourceError catch (e) {
      return Left(MostPopularMoviesFailure(message: e.message));
    } on Exception catch (e) {
      return Left(MostPopularMoviesFailure(message: e.toString()));
    }
  }
}

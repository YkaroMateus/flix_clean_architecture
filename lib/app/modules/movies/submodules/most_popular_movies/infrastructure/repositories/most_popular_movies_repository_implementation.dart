import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../../domain/entites/movies_list.dart';
import '../../domain/failures/most_popular_movies_failure.dart';
import '../../domain/repositories/most_popular_movies_repository.dart';
import '../datasource/most_popular_movies_datasource.dart';
import '../errors/most_popular_movies_datasource_error.dart';

class MostPopularMoviesRepositoryImplementation implements MostPopularMoviesRepository {
  final MostPopularMoviesDatasource datasource;

  MostPopularMoviesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, MoviesList>> call() async {
    try {
      return Right(await datasource());
    } on MostPopularMoviesDatasourceError catch (e) {
      return Left(MostPopularMoviesFailure(message: e.message));
    } on Exception catch (e) {
      return Left(MostPopularMoviesFailure(message: e.toString()));
    }
  }
}

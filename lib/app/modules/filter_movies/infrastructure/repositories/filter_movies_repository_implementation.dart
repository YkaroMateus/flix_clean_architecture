import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/repositories/filter_movies_repository.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/infrastructure/datasource/filter_movies_datasource.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/infrastructure/errors/filter_movies_datasource_error.dart';

import '../../domain/failures/filter_movies_failure.dart';

class FilterMoviesRepositoryImplementation implements FilterMoviesRepository {
  final FilterMoviesDatasource datasource;

  FilterMoviesRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failure, FilterMovies>> call() async {
    try {
      return Right(await datasource());
    } on FilterMoviesDatasourceError catch (e) {
      return Left(FilterMoviesFailure(message: e.message));
    } on Exception catch (e) {
      return Left(FilterMoviesFailure(message: e.toString()));
    }
  }
}

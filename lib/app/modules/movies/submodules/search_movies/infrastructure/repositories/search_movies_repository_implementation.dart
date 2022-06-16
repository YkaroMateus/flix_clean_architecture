import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../../domain/entites/search_movies_parameters.dart';
import '../../domain/failures/movie_not_found_failure.dart';
import '../../domain/failures/search_movies_failure.dart';
import '../../domain/repositories/search_movies_repository.dart';
import '../datasource/search_movies_datasource.dart';
import '../errors/movie_not_found_datasource_error.dart';
import '../errors/search_movies_datasource_error.dart';

class SearchMoviesRepositoryImplementation implements SearchMoviesRepository {
  final SearchMoviesDatasource datasource;

  SearchMoviesRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failure, MoviesList>> call(SearchMoviesParameters parameters) async {
    try {
      return Right(await datasource(parameters));
    } on MovieNotFoundDatasourceError catch (e) {
      return Left(MovieNotFoundFailure(e.message));
    } on SearchMoviesDatasourceError catch (e) {
      return Left(SearchMoviesFailure(e.message));
    } on Exception {
      return Left(SearchMoviesFailure('Ocorreu um erro!'));
    }
  }
}

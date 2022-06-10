import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/movie_not_found_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/repositories/search_movies_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/datasource/search_movies_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/movie_not_found_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/search_movies_datasource_error.dart';

class SearchMoviesRepositoryImplementation implements SearchMoviesRepository {
  final SearchMoviesDatasource datasource;

  SearchMoviesRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failure, SearchMoviesList>> call(SearchMoviesParameters parameters) async {
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

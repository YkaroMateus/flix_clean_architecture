import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/validators/search_movies_validators.dart';

import '../repositories/search_movies_repository.dart';

abstract class GetSearchMovie {
  Future<Either<Failure, SearchMoviesList>> call(SearchMoviesParameters parameters);
}

class GetSearchMoviesImplementation implements GetSearchMovie {
  final SearchMoviesRepository repository;
  final SearchMoviesValidators validator;

  GetSearchMoviesImplementation(this.repository, this.validator);

  @override
  Future<Either<Failure, SearchMoviesList>> call(SearchMoviesParameters parameters) async {
    if (validator.hasSearch(parameters)) {
      return await repository(parameters);
    } else {
      return Left(SearchMoviesFailure('Ocorreu um erro!'));
    }
  }
}

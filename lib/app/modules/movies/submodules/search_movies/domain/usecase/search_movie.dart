import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/empty_search_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/validators/search_movies_validators.dart';

import '../../../../domain/movie.dart';
import '../repositories/search_movies_repository.dart';

abstract class SearchMovie {
  Future<Either<Failure, List<Movie>>> call(Search parameters);
}

class SearchMoviesImplementation implements SearchMovie {
  final SearchMoviesRepository repository;
  final SearchMoviesValidators validator;

  SearchMoviesImplementation(this.repository, this.validator);

  @override
  Future<Either<Failure, List<Movie>>> call(Search parameters) async {
    if (validator.hasSearch(parameters)) {
      return await repository(parameters);
    } else {
      return Left(EmptySearchFailure('A busca não pode estar vazia'));
    }

    // if (parameters.query.isNotEmpty) {
    //   return await repository(parameters);
    // } else {
    //   return Left(EmptySearchFailure('A busca não pode estar vazia'));
    // }
  }
}

import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../entites/search_movies_parameters.dart';
import '../repositories/search_movies_repository.dart';
import '../validators/search_movies_validators.dart';

abstract class GetSearchMovie {
  Future<Either<Failure, MoviesList>> call(SearchMoviesParameters parameters);
}

class GetSearchMoviesImplementation implements GetSearchMovie {
  final SearchMoviesRepository repository;
  final SearchMoviesValidators validator;

  GetSearchMoviesImplementation(this.repository, this.validator);

  @override
  Future<Either<Failure, MoviesList>> call(SearchMoviesParameters parameters) async {
    if (validator.hasSearch(parameters)) {
      return await repository(parameters);
    }
    return await repository(parameters);
  }
}

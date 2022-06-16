import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/repositories/movies_by_genres_repository.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../entities/movies_by_genres_parameters.dart';

abstract class GetMoviesByGenres {
  Future<Either<Failure, MoviesList>> call(MoviesByGenresParameters parameters);
}

class GetMoviesByGenresImplementation implements GetMoviesByGenres {
  final MoviesByGenresRepository repository;

  GetMoviesByGenresImplementation(this.repository);

  @override
  Future<Either<Failure, MoviesList>> call(MoviesByGenresParameters parameters) async {
    return await repository(parameters);
  }
}

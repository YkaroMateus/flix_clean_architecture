import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';

abstract class MoviesByGenresRepository {
  Future<Either<Failure, MoviesList>> call(MoviesByGenresParameters parameters);
}

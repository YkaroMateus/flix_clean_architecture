import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';

abstract class GenresListRepository {
  Future<Either<Failure, GenresList>> call();
}

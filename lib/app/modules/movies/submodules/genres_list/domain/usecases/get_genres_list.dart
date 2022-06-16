import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import '../../../../../../core/errors/failure.dart';
import '../repositories/genres_list_repository.dart';

abstract class GetGenresList {
  Future<Either<Failure, GenresList>> call();
}

class GetGenresListImplementation implements GetGenresList {
  final GenresListRepository repository;

  GetGenresListImplementation(this.repository);
  @override
  Future<Either<Failure, GenresList>> call() async {
    return await repository();
  }
}

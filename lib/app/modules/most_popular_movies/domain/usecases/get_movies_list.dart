import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../entites/movies_list.dart';
import '../repositories/movies_list_repository.dart';

abstract class GetMoviesList {
  Future<Either<Failure, MoviesList>> call();
}

class GetMovieListImplementation implements GetMoviesList {
  final MoviesListRepository repository;

  GetMovieListImplementation(this.repository);

  @override
  Future<Either<Failure, MoviesList>> call() async {
    return await repository();
  }
}

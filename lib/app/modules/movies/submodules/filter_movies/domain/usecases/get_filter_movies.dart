import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../entites/filter_movies.dart';
import '../repositories/filter_movies_repository.dart';

abstract class GetFilterMovies {
  Future<Either<Failure, FilterMovies>> call();
}

class GetFilterMoviesImplementation implements GetFilterMovies {
  final FilterMoviesRepository repository;

  GetFilterMoviesImplementation(this.repository);
  @override
  Future<Either<Failure, FilterMovies>> call() async {
    return await repository();
  }
}

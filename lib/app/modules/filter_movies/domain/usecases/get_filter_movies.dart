import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/repositories/filter_movies_repository.dart';
import '../../../../core/errors/failure.dart';
import '../entites/filter_movies.dart';

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

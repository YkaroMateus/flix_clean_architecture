import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../entites/filter_movies.dart';

abstract class FilterMoviesRepository {
  Future<Either<Failure, FilterMovies>> call();
}

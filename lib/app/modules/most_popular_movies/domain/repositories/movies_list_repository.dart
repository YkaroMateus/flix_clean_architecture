import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/movies_list.dart';

abstract class MoviesListRepository {
  Future<Either<Failure, MoviesList>> call();
}

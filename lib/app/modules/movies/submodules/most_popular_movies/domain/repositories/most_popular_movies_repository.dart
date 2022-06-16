import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';

abstract class MostPopularMoviesRepository {
  Future<Either<Failure, MoviesList>> call();
}

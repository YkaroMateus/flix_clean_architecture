import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movie.dart';
import '../entites/search.dart';

abstract class SearchMoviesRepository {
  Future<Either<Failure, List<Movie>>> call(Search parameters);
}

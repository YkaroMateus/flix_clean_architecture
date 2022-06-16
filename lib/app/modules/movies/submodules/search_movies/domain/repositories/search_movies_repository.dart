import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../entites/search_movies_parameters.dart';

abstract class SearchMoviesRepository {
  Future<Either<Failure, MoviesList>> call(SearchMoviesParameters parameters);
}

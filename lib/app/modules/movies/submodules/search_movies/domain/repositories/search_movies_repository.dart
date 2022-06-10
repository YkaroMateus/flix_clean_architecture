import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import '../../../../../../core/errors/failure.dart';
import '../entites/search_movies_parameters.dart';

abstract class SearchMoviesRepository {
  Future<Either<Failure, SearchMoviesList>> call(SearchMoviesParameters parameters);
}

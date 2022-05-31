import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movies_list.dart';

abstract class MoviesListDatasource {
  Future<MoviesList> call();
}

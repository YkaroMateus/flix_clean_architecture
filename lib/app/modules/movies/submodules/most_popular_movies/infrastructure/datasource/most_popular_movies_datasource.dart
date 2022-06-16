import '../../../../domain/movies_list.dart';

abstract class MostPopularMoviesDatasource {
  Future<MoviesList> call();
}

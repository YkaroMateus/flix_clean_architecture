import '../../../../domain/movies_list.dart';
import '../../domain/entities/movies_by_genres_parameters.dart';

abstract class MoviesByGenresDatasource {
  Future<MoviesList> call(MoviesByGenresParameters parameters);
}

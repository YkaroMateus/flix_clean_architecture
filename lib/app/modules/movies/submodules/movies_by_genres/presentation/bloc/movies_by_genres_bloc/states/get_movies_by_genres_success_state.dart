import '../../../../../../domain/movies_list.dart';
import 'movies_by_genres_states.dart';

class GetMoviesByGenresSuccessState implements MoviesByGenresStates {
  final MoviesList moviesByGenres;

  GetMoviesByGenresSuccessState(this.moviesByGenres);
}

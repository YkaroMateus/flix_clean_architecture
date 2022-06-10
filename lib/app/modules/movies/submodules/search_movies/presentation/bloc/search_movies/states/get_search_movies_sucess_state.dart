import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/search_movies_states.dart';

class GetSearchMoviesSucessState implements SearchMoviesStates {
  final SearchMoviesList searchMoviesList;

  GetSearchMoviesSucessState(this.searchMoviesList);
}

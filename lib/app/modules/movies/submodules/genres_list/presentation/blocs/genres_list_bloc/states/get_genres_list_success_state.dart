import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import 'genres_list_states.dart';

class GetGenresListSuccessState implements GenresListStates {
  final GenresList genresList;

  GetGenresListSuccessState(this.genresList);
}

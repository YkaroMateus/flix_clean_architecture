import '../../../../domain/entites/search_movies_parameters.dart';
import 'search_movies_events.dart';

class SearchMoviesEvent implements SearchMoviesEvents {
  final SearchMoviesParameters parameters;

  SearchMoviesEvent(this.parameters);
}

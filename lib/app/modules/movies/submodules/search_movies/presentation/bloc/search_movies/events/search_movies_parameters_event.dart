import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/events/search_movies_events.dart';

import '../../../../domain/entites/search_movies_parameters.dart';

class SearchMoviesParametersEvent implements SearchMoviesEvents {
  final SearchMoviesParameters parameters;

  SearchMoviesParametersEvent(this.parameters);
}

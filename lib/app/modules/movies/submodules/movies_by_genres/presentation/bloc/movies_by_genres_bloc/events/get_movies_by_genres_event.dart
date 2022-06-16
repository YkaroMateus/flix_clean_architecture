import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/movies_by_genres_events.dart';

class GetMoviesByGenresEvent implements MoviesByGenresEvents {
  final MoviesByGenresParameters parameters;
  

  GetMoviesByGenresEvent(this.parameters);
}

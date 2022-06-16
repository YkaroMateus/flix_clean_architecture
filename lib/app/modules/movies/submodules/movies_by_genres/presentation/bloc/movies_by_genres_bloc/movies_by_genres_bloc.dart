
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/reset_movies_by_genres_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/movies_by_genres_failure.dart';
import '../../../domain/usecases/get_movies_by_genres.dart';
import 'events/get_movies_by_genres_event.dart';
import 'events/movies_by_genres_events.dart';
import 'states/get_movies_by_genres_failure_state.dart';
import 'states/movies_by_genres_initial_state.dart';
import 'states/get_movies_by_genres_loading_state.dart';
import 'states/get_movies_by_genres_success_state.dart';
import 'states/movies_by_genres_states.dart';

class MoviesByGenresBloc extends Bloc<MoviesByGenresEvents, MoviesByGenresStates> implements Disposable {
  final GetMoviesByGenres usecase;

  MoviesByGenresBloc(this.usecase) : super(MoviesByGenresInitialState()) {
    on<GetMoviesByGenresEvent>(_mapGetMoviesByGenresEventToState);
    on<ResetMoviesByGenresEvent>(_mapResetMoviesByGenresEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapGetMoviesByGenresEventToState(
      GetMoviesByGenresEvent event, Emitter<MoviesByGenresStates> emit) async {
    emit(GetMoviesByGenresLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) => emit(GetMoviesByGenresFailureState(l as MoviesByGenresFailure)),
      (r) => emit(GetMoviesByGenresSuccessState(r)),
    );
  }

  void _mapResetMoviesByGenresEventToState(
      ResetMoviesByGenresEvent event, Emitter<MoviesByGenresStates> emit) {
    emit(MoviesByGenresInitialState());
  }
}

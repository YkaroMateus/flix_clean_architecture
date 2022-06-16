import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/movie_not_found_failure.dart';
import '../../../domain/failures/search_movies_failure.dart';
import '../../../domain/usecase/get_search_movie.dart';
import 'events/search_movies_event.dart';
import 'events/search_movies_events.dart';
import 'states/get_search_movies_loading_state.dart';
import 'states/get_search_movies_sucess_state.dart';
import 'states/get_serach_movies_failure_state.dart';
import 'states/movie_not_found_failure_state.dart';
import 'states/search_movies_states.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvents, SearchMoviesStates> implements Disposable {
  final GetSearchMovie usecase;

  SearchMoviesBloc(this.usecase) : super(GetSearchMoviesLoadingState()) {
    on<SearchMoviesEvent>(_mapSearchMoviesParametersEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapSearchMoviesParametersEventToState(
      SearchMoviesEvent event, Emitter<SearchMoviesStates> emit) async {
    emit(GetSearchMoviesLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) {
        switch (l.runtimeType) {
          case SearchMoviesFailure:
            emit(GetSearchMoviesFailureState(l as SearchMoviesFailure));
            break;
          case MovieNotFoundFailure:
            emit(MovieNotFoundFailureState(l as MovieNotFoundFailure));
            break;
        }
      },
      (r) => emit(GetSearchMoviesSucessState(r)),
    );
  }
}

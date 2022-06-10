import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/usecase/get_search_movie.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/events/search_movies_events.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/events/search_movies_parameters_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_search_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_search_movies_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_serach_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/search_movies_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvents, SearchMoviesStates> implements Disposable {
  final GetSearchMovie usecase;

  SearchMoviesBloc(this.usecase) : super(GetSearchMoviesLoadingState()) {
    on<SearchMoviesParametersEvent>(_mapSearchMoviesParametersEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapSearchMoviesParametersEventToState(
      SearchMoviesParametersEvent event, Emitter<SearchMoviesStates> emit) async {
    emit(GetSearchMoviesLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) {
        switch (l.runtimeType) {
          case SearchMoviesFailure:
            emit(GetSearchMoviesFailureState(l as SearchMoviesFailure));
            break;
        }
      },
      (r) => emit(GetSearchMoviesSucessState(r)),
    );
  }
}

import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/blocs/get_filter_movies/states/filter_movies_states.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_sucess_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/filter_movies_failure.dart';
import '../../../domain/usecases/get_filter_movies.dart';
import 'events/filter_movies_events.dart';
import 'events/get_filter_movies_event.dart';

class GetFilterMoviesBloc extends Bloc<FilterMoviesEvents, FilterMoviesStates> implements Disposable {
  final GetFilterMovies usecase;

  GetFilterMoviesBloc(this.usecase) : super(GetFilterMoviesLoadingState()) {
    on<GetFilterMoviesEvent>(_mapFilterMoviesEventToState);
  }
  @override
  void dispose() {
    close();
  }

  void _mapFilterMoviesEventToState(GetFilterMoviesEvent event, Emitter<FilterMoviesStates> emit) async {
    emit(GetFilterMoviesLoadingState());

    final result = await usecase();

    result.fold(
      (l) => emit(GetFilterMoviesFailureState(l as FilterMoviesFailure)),
      (r) => emit(GetFilterMoviesSucessState(r)),
    );
  }
}

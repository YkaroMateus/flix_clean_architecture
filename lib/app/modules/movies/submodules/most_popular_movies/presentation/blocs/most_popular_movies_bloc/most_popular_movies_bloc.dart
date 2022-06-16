import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/events/reset_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/most_popular_movies_initial_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/most_popular_movies_states.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/failures/most_popular_movies_failure.dart';
import '../../../domain/usecases/get_most_popular_movies.dart';
import 'events/get_most_popular_movies_event.dart';
import 'events/most_popular_movies_events.dart';

class MostPopularMoviesBloc extends Bloc<MostPopularMoviesEvents, MostPopularMoviesStates>
    implements Disposable {
  final GetMostPopularMovies usecase;

  MostPopularMoviesBloc(this.usecase) : super(MostPopularMoviesInitialState()) {
    on<GetMostPopularMoviesEvent>(_mapMostPopularMoviesEventToState);
    on<ResetMostPopularMoviesEvent>(_mapResetMostPopularMoviesEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapMostPopularMoviesEventToState(
      GetMostPopularMoviesEvent event, Emitter<MostPopularMoviesStates> emit) async {
    emit(GetMostPopularMoviesLoadingState());

    final result = await usecase();

    result.fold(
      (l) => emit(GetMostPopularMoviesFailureState(l as MostPopularMoviesFailure)),
      (r) => emit(GetMostPopularMoviesSucessState(r)),
    );
  }

  void _mapResetMostPopularMoviesEventToState(
      ResetMostPopularMoviesEvent event, Emitter<MostPopularMoviesStates> emit) {
    emit(MostPopularMoviesInitialState());
  }
}

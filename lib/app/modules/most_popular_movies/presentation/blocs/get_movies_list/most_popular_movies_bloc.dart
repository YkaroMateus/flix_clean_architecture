import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/usecases/get_movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_failure_state.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_loading_state.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/most_popular_movies_states.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/failures/movies_list_failure.dart';
import 'events/get_movies_list_event.dart';
import 'events/most_popular_movies_events.dart';

class MostPopularMoviesBloc extends Bloc<MostPopularMoviesEvents, MostPopularMoviesStates>
    implements Disposable {
  final GetMoviesList usecase;

  MostPopularMoviesBloc(this.usecase) : super(GetMoviesListLoadingState()) {
    on<GetMoviesListEvent>(_mapMostPopularMoviesEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapMostPopularMoviesEventToState(
      GetMoviesListEvent event, Emitter<MostPopularMoviesStates> emit) async {
    emit(GetMoviesListLoadingState());

    final result = await usecase();

    result.fold(
      (l) => emit(GetMoviesListFailureState(l as MoviesListFailure)),
      (r) => emit(GetMoviesListSucessState(r)),
    );
  }
}

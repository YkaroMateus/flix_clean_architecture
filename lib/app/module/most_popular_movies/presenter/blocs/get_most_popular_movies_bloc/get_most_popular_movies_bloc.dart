import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/usecases/get_most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/events/get_most_popular_movies_events.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_states.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/most_popular_movies_failure.dart';
import 'events/get_most_popular_movies_event.dart';

class GetMostPopularMoviesBloc extends Bloc<GetMostPopularMoviesEvents, GetMostPopularMoviesStates>
    implements Disposable {
  final GetMostPopularMovies usecase;
  GetMostPopularMoviesBloc(this.usecase) : super(GetMostPopularMoviesLoadingState()) {
    on<GetMostPopularMoviesEvent>(_mapGetMostPopularMoviesEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapGetMostPopularMoviesEventToState(
      GetMostPopularMoviesEvent event, Emitter<GetMostPopularMoviesStates> emit) async {
    emit(GetMostPopularMoviesLoadingState());

    final result = await usecase();

    result.fold(
      (l) {
        switch (l.runtimeType) {
          case MostPopularMoviesFailure:
            emit(GetMostPopularMoviesFailureState(l as MostPopularMoviesFailure));
            break;
        }
      },
      (r) => emit(GetMostPopularMoviesSucessState(r)),
    );
  }
}

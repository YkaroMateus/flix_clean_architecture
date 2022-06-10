import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/movie_details_states.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/failures/movie_details_failure.dart';
import '../../../domain/usecases/get_movie_details.dart';
import 'events/get_movie_details_event.dart';
import 'events/movie_details_events.dart';
import 'states/get_movie_details_failure_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvents, MovieDetailsStates> implements Disposable {
  final GetMovieDetails usecase;

  MovieDetailsBloc(this.usecase) : super(GetMovieDetailsLoadingState()) {
    on<GetMovieDetailsEvent>(_mapGetMovieDetailsEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapGetMovieDetailsEventToState(GetMovieDetailsEvent event, Emitter<MovieDetailsStates> emit) async {
    emit(GetMovieDetailsLoadingState());

    final result = await usecase(event.parameters);

    result.fold(
      (l) {
        switch (l.runtimeType) {
          case MovieDetailsFailure:
            emit(GetMovieDetailsFailureState(l as MovieDetailsFailure));
            break;
        }
      },
      (r) => emit(GetMovieDetailsSucessState(r)),
    );
  }
}

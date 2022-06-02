import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/modules/movie_details/domain/usecases/get_movie_details.dart';
import 'package:flix_clean_ark/app/modules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movie_details/presentation/blocs/get_movie_details_bloc/states/movie_details_states.dart';
import 'package:flix_clean_ark/app/modules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/entites/movie_details_parameters.dart';
import '../../../domain/failures/movie_details_failure.dart';
import 'events/get_movie_details_event.dart';
import 'events/movie_details_events.dart';

class GetMovieDetailsBloc extends Bloc<MovieDetailsEvents, MovieDetailsStates> implements Disposable {
  final GetMovieDetails usecase;
  final MovieDetailsParameters parameters;
  GetMovieDetailsBloc(this.usecase, this.parameters) : super(GetMovieDetailsLoadingState()) {
    on<GetMovieDetailsEvent>(_mapGetMovieDetailsEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapGetMovieDetailsEventToState(GetMovieDetailsEvent event, Emitter<MovieDetailsStates> emit) async {
    emit(GetMovieDetailsLoadingState());

    final result = await usecase(parameters);

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

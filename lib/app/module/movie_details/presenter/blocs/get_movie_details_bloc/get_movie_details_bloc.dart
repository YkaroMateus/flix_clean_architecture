import 'package:bloc/bloc.dart';
import 'package:flix_clean_ark/app/module/movie_details/domain/usecases/get_movie_details.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_failure_state.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_states.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../domain/failures/movie_details_failure.dart';
import 'events/get_movie_details_event.dart';
import 'events/get_movie_details_events.dart';

class GetMovieDetailsBloc extends Bloc<GetMovieDetailsEvents, GetMovieDetailsStates> implements Disposable {
  final GetMovieDetails usecase;
  GetMovieDetailsBloc(this.usecase) : super(GetMovieDetailsLoadingState()) {
    on<GetMovieDetailsEvent>(_mapGetMovieDetailsEventToState);
  }

  @override
  void dispose() {
    close();
  }

  void _mapGetMovieDetailsEventToState(
      GetMovieDetailsEvent event, Emitter<GetMovieDetailsStates> emit) async {
    emit(GetMovieDetailsLoadingState());

    final result = await usecase();

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

import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/genres_list_states.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_success_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/failures/genres_list_failure.dart';
import '../../../domain/usecases/get_genres_list.dart';
import 'events/genres_list_events.dart';
import 'events/get_genres_list_event.dart';

class GenresListBloc extends Bloc<GenresListEvents, GenresListStates> implements Disposable {
  final GetGenresList usecase;

  GenresListBloc(this.usecase) : super(GetGenresListLoadingState()) {
    on<GetGenresListEvent>(_mapGenresListEventToState);
  }
  @override
  void dispose() {
    close();
  }

  void _mapGenresListEventToState(GetGenresListEvent event, Emitter<GenresListStates> emit) async {
    emit(GetGenresListLoadingState());

    final result = await usecase();

    result.fold(
      (l) => emit(GetGenresListFailureState(l as GenresListFailure)),
      (r) => emit(GetGenresListSuccessState(r)),
    );
  }
}

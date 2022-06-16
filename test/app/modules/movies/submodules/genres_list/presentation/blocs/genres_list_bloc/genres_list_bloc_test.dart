import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/failures/genres_list_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/usecases/get_genres_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/events/get_genres_list_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/genres_list_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_success_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetGenresListMock extends Mock implements GetGenresList {}

class GenresListFake extends Fake implements GenresList {}

void main() {
  final usecase = GetGenresListMock();
  final bloc = GenresListBloc(usecase);

  test(
    'Must emit all states in order on success',
    () {
      when(() => usecase()).thenAnswer((invocation) async => Right(GenresListFake()));

      bloc.add(GetGenresListEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          isA<GetGenresListLoadingState>(),
          isA<GetGenresListSuccessState>(),
        ]),
      );
    },
  );
  test(
    'Must emit all states in order on GenresListFailure failure',
    () {
      when(() => usecase())
          .thenAnswer((invocation) async => Left(GenresListFailure(message: 'Ocorreu um erro!')));

      bloc.add(GetGenresListEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          isA<GetGenresListLoadingState>(),
          isA<GetGenresListFailureState>(),
        ]),
      );
    },
  );
}

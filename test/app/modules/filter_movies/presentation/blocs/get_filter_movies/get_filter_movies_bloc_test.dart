import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/failures/filter_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/usecases/get_filter_movies.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/events/get_filter_movies_event.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/get_filter_movies_bloc.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/states/get_filter_movies_sucess_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetFilterMoviesMock extends Mock implements GetFilterMovies {}

class FilterMoviesFake extends Fake implements FilterMovies {}

void main() {
  final usecase = GetFilterMoviesMock();
  final bloc = GetFilterMoviesBloc(usecase);

  test(
    'Must emit all states in order on success',
    () {
      when(() => usecase()).thenAnswer((invocation) async => Right(FilterMoviesFake()));

      bloc.add(GetFilterMoviesEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          isA<GetFilterMoviesLoadingState>(),
          isA<GetFilterMoviesSucessState>(),
        ]),
      );
    },
  );
  test(
    'Must emit all states in order on FilterMoviesFailure failure',
    () {
      when(() => usecase())
          .thenAnswer((invocation) async => Left(FilterMoviesFailure(message: 'Ocorreu um erro!')));

      bloc.add(GetFilterMoviesEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          isA<GetFilterMoviesLoadingState>(),
          isA<GetFilterMoviesFailureState>(),
        ]),
      );
    },
  );
}

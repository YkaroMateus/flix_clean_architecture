import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/failures/movies_list_failure.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/usecases/get_movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/events/get_movies_list_event.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/most_popular_movies_bloc.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_failure_state.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_loading_state.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_sucess_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMoviesListMock extends Mock implements GetMoviesList {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final usecase = GetMoviesListMock();
  final bloc = MostPopularMoviesBloc(usecase);

  test('Must emit all states in order on success', () {
    when(() => usecase()).thenAnswer((invocation) async => Right(MoviesListFake()));

    bloc.add(GetMoviesListEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMoviesListLoadingState>(),
          isA<GetMoviesListSucessState>(),
        ]));
  });
  test('Must emit all states in order on MovieFailure failure', () {
    when(() => usecase()).thenAnswer((invocation) async => Left(MoviesListFailure(message: 'erro')));

    bloc.add(GetMoviesListEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMoviesListLoadingState>(),
          isA<GetMoviesListFailureState>(),
        ]));
  });
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/usecases/get_most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/events/get_most_popular_movies_events.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/get_most_popular_movies_bloc.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMostPopularMoviesMock extends Mock implements GetMostPopularMovies {}

class MostPopularMoviesFake extends Fake implements MostPopularMovies {}

void main() {
  final usecase = GetMostPopularMoviesMock();
  final bloc = GetMostPopularMoviesBloc(usecase);

  test('Must emit all states in order on success', () {
    when(() => usecase()).thenAnswer((invocation) async => Right(MostPopularMoviesFake()));

    bloc.add(GetMostPopularMoviesEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMostPopularMoviesLoadingState>(),
          isA<GetMostPopularMoviesSucessState>(),
        ]));
  });
  test('Must emit all states in order on ImageOfTheDayFailure failure', () {
    when(() => usecase()).thenAnswer((invocation) async => Left(MostPopularMoviesFailure(message: 'erro')));

    bloc.add(GetMostPopularMoviesEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMostPopularMoviesLoadingState>(),
          isA<GetMostPopularMoviesFailureState>(),
        ]));
  });
}

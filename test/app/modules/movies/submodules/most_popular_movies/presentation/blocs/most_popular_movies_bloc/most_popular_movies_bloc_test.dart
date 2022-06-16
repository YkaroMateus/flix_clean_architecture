import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/usecases/get_most_popular_movies.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/events/get_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/events/reset_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/most_popular_movies_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/most_popular_movies_initial_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMostPopularMoviesMock extends Mock implements GetMostPopularMovies {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final usecase = GetMostPopularMoviesMock();
  final bloc = MostPopularMoviesBloc(usecase);

  test('Must emit all states in order on success', () {
    when(() => usecase()).thenAnswer((invocation) async => Right(MoviesListFake()));

    bloc.add(GetMostPopularMoviesEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMostPopularMoviesLoadingState>(),
          isA<GetMostPopularMoviesSucessState>(),
        ]));
  });

  test('Must emit all states in order on MostPopularMoviesFailure failure', () {
    when(() => usecase()).thenAnswer((invocation) async => Left(MostPopularMoviesFailure(message: 'erro')));

    bloc.add(GetMostPopularMoviesEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMostPopularMoviesLoadingState>(),
          isA<GetMostPopularMoviesFailureState>(),
        ]));
  });

    test('Must emit all states in order on ResetMostPopularMoviesEvent', () {

    bloc.add(ResetMostPopularMoviesEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<MostPopularMoviesInitialState>(),
        ]));
  });

  
}

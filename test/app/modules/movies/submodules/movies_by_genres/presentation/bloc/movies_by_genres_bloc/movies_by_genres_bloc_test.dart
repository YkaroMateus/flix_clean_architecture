import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genre.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/failures/movies_by_genres_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/usecases/get_movies_by_genres.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/get_movies_by_genres_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/reset_movies_by_genres_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/movies_by_genres_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_success_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/movies_by_genres_initial_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMoviesByGenresMock extends Mock implements GetMoviesByGenres {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final usecase = GetMoviesByGenresMock();
  final bloc = MoviesByGenresBloc(usecase);

  final parameters = MoviesByGenresParameters(Genre(id: -1, name: ''));
  
  test('Must emit all states in order on success', () {
    when(() => usecase(parameters)).thenAnswer((invocation) async => Right(MoviesListFake()));

    bloc.add(GetMoviesByGenresEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMoviesByGenresLoadingState>(),
          isA<GetMoviesByGenresSuccessState>(),
        ]));
  });

  test('Must emit all states in order on MoviesByGenresFailure failure', () {
    when(() => usecase(parameters)).thenAnswer((invocation) async => Left(MoviesByGenresFailure('Erro')));

    bloc.add(GetMoviesByGenresEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMoviesByGenresLoadingState>(),
          isA<GetMoviesByGenresFailureState>(),
        ]));
  });

    test('Must emit all states in order on ResetMoviesByGenresEvent', () {

    bloc.add(ResetMoviesByGenresEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<MoviesByGenresInitialState>(),
        ]));
  });

  
}

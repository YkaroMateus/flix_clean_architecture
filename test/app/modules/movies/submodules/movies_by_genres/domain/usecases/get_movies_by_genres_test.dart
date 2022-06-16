import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genre.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/failures/movies_by_genres_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/repositories/movies_by_genres_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/usecases/get_movies_by_genres.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MoviesByGenresRepositoryMock extends Mock implements MoviesByGenresRepository {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final repository = MoviesByGenresRepositoryMock();
  final usecase = GetMoviesByGenresImplementation(repository);

  final parameters = MoviesByGenresParameters(Genre(id: -1, name: ''));

  test('Must return MoviesByGenres entity on sucess', () async {
    when(() => repository(parameters)).thenAnswer((invocation) async => Right(MoviesListFake()));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<MoviesList>());
  });
  test('Must return MoviesByGenresFailure entity on failure', () async {
    when(() => repository(parameters)).thenAnswer((invocation) async => Left(MoviesByGenresFailure('Erro')));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<MoviesByGenresFailure>());
  });
}

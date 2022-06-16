import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genre.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/failures/movies_by_genres_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/infrastructure/datasource/movies_by_genres_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/infrastructure/errors/movies_by_genres_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/infrastructure/repositories/movies_by_genres_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MoviesByGenresDatasourceMock extends Mock implements MoviesByGenresDatasource {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final datasource = MoviesByGenresDatasourceMock();
  final repository = MoviesByGenresRepositoryImplementation(datasource);

  final parameters = MoviesByGenresParameters(Genre(id: -1, name: ''));

  test('Must return an MoviesByGenres on success', () async {
    when(() => datasource(parameters)).thenAnswer((invocation) async => MoviesListFake());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MoviesList>());
  });
  test('Must return a MoviesByGenresFailure on MoviesByGenresDatasourceError', () async {
    when(() => datasource(parameters)).thenThrow(MoviesByGenresDatasourceError('Erro!'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MoviesByGenresFailure>());
  });
  test('Must return a MoviesByGenresFailure on Exception', () async {
    when(() => datasource(parameters)).thenThrow(Exception());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MoviesByGenresFailure>());
  });
}

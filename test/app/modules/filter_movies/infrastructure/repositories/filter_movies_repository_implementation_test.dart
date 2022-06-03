import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/domain/failures/filter_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/infrastructure/datasource/filter_movies_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/infrastructure/errors/filter_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/infrastructure/repositories/filter_movies_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FilterMoviesDatasourceMock extends Mock implements FilterMoviesDatasource {}

class FilterMoviesFake extends Fake implements FilterMovies {}

void main() {
  final datasource = FilterMoviesDatasourceMock();
  final repository = FilterMoviesRepositoryImplementation(datasource);

  test('Must return an FilterMovies on success', () async {
    when(() => datasource()).thenAnswer((invocation) async => FilterMoviesFake());

    final result = await repository();

    expect(result.fold(id, id), isA<FilterMovies>());
  });
  test('Must return an FilterMoviesFailure on FilterMoviesDatasourceError', () async {
    when(() => datasource()).thenThrow(FilterMoviesDatasourceError(message: 'erro'));

    final result = await repository();

    expect(result.fold(id, id), isA<FilterMoviesFailure>());
  });

  test('Must return an FilterMoviesFailure on Exception', () async {
    when(() => datasource()).thenThrow(Exception());

    final result = await repository();

    expect(result.fold(id, id), isA<FilterMoviesFailure>());
  });
}

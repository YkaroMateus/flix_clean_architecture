import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/movie_not_found_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/datasource/search_movies_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/movie_not_found_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/search_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/repositories/search_movies_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchMoviesDatasourceMock extends Mock implements SearchMoviesDatasource {}

class SearchMoviesListFake extends Fake implements SearchMoviesList {}

void main() {
  final datasource = SearchMoviesDatasourceMock();
  final repository = SearchMoviesRepositoryImplementation(datasource);

  final parameters = SearchMoviesParameters('lala');

  test('Must return an SearchMoviesList on success', () async {
    when(() => datasource(parameters)).thenAnswer((invocation) async => SearchMoviesListFake());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<SearchMoviesList>());
  });
  test('Must throw a MovieNotFoundFailure on MovieNotFoundDatasourceError', () async {
    when(() => datasource(parameters)).thenThrow(MovieNotFoundDatasourceError(message: 'erro'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MovieNotFoundFailure>());
  });
  test('Must throw a SearchMoviesFailure on SearchMoviesDatasourceError', () async {
    when(() => datasource(parameters)).thenThrow(SearchMoviesDatasourceError('erro'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<SearchMoviesFailure>());
  });
  test('Must throw a SearchMoviesFailure on Exception', () async {
    when(() => datasource(parameters)).thenThrow(Exception());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<SearchMoviesFailure>());
  });
}

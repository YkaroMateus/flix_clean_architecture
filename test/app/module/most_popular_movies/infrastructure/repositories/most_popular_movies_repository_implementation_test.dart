import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/datasource/most_popular_movie_datasource.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/errors/most_popular_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/models/most_popular_movies_model.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/repositories/most_popular_movies_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MostPopularMoviesModelFake extends Fake implements MostPopularMoviesModel {}

class MostPopularMoviesDatasourceMock extends Mock implements MostPopularMoviesDatasource {}

void main() {
  final datasource = MostPopularMoviesDatasourceMock();
  final repository = MostPopularMoviesRepositoryImplementation(datasource);

  test('Must return an MostPopularMoviesModel on success', () async {
    when(() => datasource()).thenAnswer((invocation) async => MostPopularMoviesModelFake());

    final result = await repository();

    expect(result.fold(id, id), isA<MostPopularMoviesModel>());
  });

  test('Must return an MostPopularMoviesFailure on MostPopularMoviesDatasourceError', () async {
    when(() => datasource()).thenThrow(MostPopularMoviesDatasourceError(message: 'erro'));

    final result = await repository();

    expect(result.fold(id, id), isA<MostPopularMoviesFailure>());
  });

  test('Must return an MostPopularMoviesFailure on Exception', () async {
    when(() => datasource()).thenThrow(Exception());

    final result = await repository();

    expect(result.fold(id, id), isA<MostPopularMoviesFailure>());
  });
}

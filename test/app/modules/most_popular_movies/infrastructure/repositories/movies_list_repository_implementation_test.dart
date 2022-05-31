import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/failures/movies_list_failure.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/datasource/movies_list_datasource.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/errors/movies_list_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/repositories/movies_list_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MoviesListFake extends Fake implements MoviesList {}

class MoviesListDatasourceMock extends Mock implements MoviesListDatasource {}

void main() {
  final datasource = MoviesListDatasourceMock();
  final repository = MoviesListRepositoryImplementation(datasource);

  test('Must return an MoviesList on success', () async {
    when(() => datasource()).thenAnswer((invocation) async => MoviesListFake());

    final result = await repository();

    expect(result.fold(id, id), isA<MoviesList>());
  });

  test('Must return an MoviesListFailure on MoviesListDatasourceError', () async {
    when(() => datasource()).thenThrow(MoviesListDatasourceError(message: 'erro'));

    final result = await repository();

    expect(result.fold(id, id), isA<MoviesListFailure>());
  });

  test('Must return an MoviesListFailure on Exception', () async {
    when(() => datasource()).thenThrow(Exception());

    final result = await repository();

    expect(result.fold(id, id), isA<MoviesListFailure>());
  });
}

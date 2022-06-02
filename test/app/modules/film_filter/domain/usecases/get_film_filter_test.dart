import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/failures/filter_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/repositories/filter_movies_repository.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/domain/usecases/get_filter_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FilterMoviesRepositoryMock extends Mock implements FilterMoviesRepository {}

class FilterMoviesFake extends Fake implements FilterMovies {}

void main() {
  final repository = FilterMoviesRepositoryMock();
  final usecase = GetFilterMoviesImplementation(repository);

  test('Must return an FilterMovies entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(FilterMoviesFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<FilterMovies>());
  });
  test('Must return FilterMoviesFailure on failure', () async {
    when(() => repository()).thenAnswer((invocation) async => Left((FilterMoviesFailure(message: 'Erro'))));

    final result = await usecase();

    expect(result.fold(id, id), isA<FilterMoviesFailure>());
  });
}

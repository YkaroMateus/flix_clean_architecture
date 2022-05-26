import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/repositories/most_popular_movies_repository.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/domain/usecases/get_most_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MostPopularMoviesRepositoryMock extends Mock
    implements MostPopularMoviesRepository {}

class MostPopularMoviesFake extends Fake implements MostPopularMovies {}

void main() {
  final repository = MostPopularMoviesRepositoryMock();
  final usecase = GetMostPopularMoviesImplementation(repository);

  test('Must return an MostPopularMovies entity on success', () async {
    when(() => repository())
        .thenAnswer((invocation) async => Right(MostPopularMoviesFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<MostPopularMovies>());
  });

  test('Must return MostPopularMoviesFailure on Failure', () async {
    when(() => repository()).thenAnswer(
        (invocation) async => Left(MostPopularMoviesFailure(message: '')));

    final result = await usecase();

    expect(result.fold(id, id), isA<MostPopularMoviesFailure>());
  });
}

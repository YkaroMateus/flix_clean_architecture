import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/failures/most_popular_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/repositories/most_popular_movies_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/usecases/get_most_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MostPopularMoviesRepositoryMock extends Mock implements MostPopularMoviesRepository {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final repository = MostPopularMoviesRepositoryMock();
  final usecase = GetMostPopularMoviesImplementation(repository);

  test('Must return an MoviesList entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(MoviesListFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<MoviesList>());
  });

  test('Must return MostPopularMoviesFailure on Failure', () async {
    when(() => repository())
        .thenAnswer((invocation) async => Left(MostPopularMoviesFailure(message: 'erro')));

    final result = await usecase();

    expect(result.fold(id, id), isA<MostPopularMoviesFailure>());
  });
}

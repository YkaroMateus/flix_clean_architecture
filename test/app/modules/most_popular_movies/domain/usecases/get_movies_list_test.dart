import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/failures/movies_list_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/repositories/movies_list_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/usecases/get_movies_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MoviesListRepositoryMock extends Mock implements MoviesListRepository {}

class MoviesListFake extends Fake implements MoviesList {}

void main() {
  final repository = MoviesListRepositoryMock();
  final usecase = GetMoviesListImplementation(repository);

  test('Must return an MoviesList entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(MoviesListFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<MoviesList>());
  });

  test('Must return MoviesListFailure on Failure', () async {
    when(() => repository()).thenAnswer((invocation) async => Left(MoviesListFailure(message: 'erro')));

    final result = await usecase();

    expect(result.fold(id, id), isA<MoviesListFailure>());
  });
}

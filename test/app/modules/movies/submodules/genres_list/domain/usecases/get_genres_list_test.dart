import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/failures/genres_list_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/repositories/genres_list_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/usecases/get_genres_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GenresListRepositoryMock extends Mock implements GenresListRepository {}

class GenresListFake extends Fake implements GenresList {}

void main() {
  final repository = GenresListRepositoryMock();
  final usecase = GetGenresListImplementation(repository);

  test('Must return a GenresList entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(GenresListFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<GenresList>());
  });

  test('Must return a GenresListFailure on failure', () async {
    when(() => repository()).thenAnswer((invocation) async => Left((GenresListFailure(message: 'Erro'))));

    final result = await usecase();

    expect(result.fold(id, id), isA<GenresListFailure>());
  });
}

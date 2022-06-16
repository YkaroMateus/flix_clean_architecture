import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/failures/genres_list_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/infrastructure/datasource/genres_list_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/infrastructure/errors/genres_list_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/infrastructure/repositories/genres_list_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GenresListDatasourceMock extends Mock implements GenresListDatasource {}

class GenresListFake extends Fake implements GenresList {}

void main() {
  final datasource = GenresListDatasourceMock();
  final repository = GenresListRepositoryImplementation(datasource);

  test('Must return a GenresList on success', () async {
    when(() => datasource()).thenAnswer((invocation) async => GenresListFake());

    final result = await repository();

    expect(result.fold(id, id), isA<GenresList>());
  });
  test('Must return a GenresListFailure on GenresListDatasourceError', () async {
    when(() => datasource()).thenThrow(GenresListDatasourceError(message: 'erro'));

    final result = await repository();

    expect(result.fold(id, id), isA<GenresListFailure>());
  });

  test('Must return a GenresListFailure on Exception', () async {
    when(() => datasource()).thenThrow(Exception());

    final result = await repository();

    expect(result.fold(id, id), isA<GenresListFailure>());
  });
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/film_filter/domain/entites/film_filter.dart';
import 'package:flix_clean_ark/app/module/film_filter/domain/failures/film_filter_failure.dart';
import 'package:flix_clean_ark/app/module/film_filter/domain/repositories/film_filter_repository.dart';
import 'package:flix_clean_ark/app/module/film_filter/domain/usecases/get_film_filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FilmFilterRepositoryMock extends Mock implements FilmFilterRepository {}

class FilmFilterFake extends Fake implements FilmFilter {}

void main() {
  final repository = FilmFilterRepositoryMock();
  final usecase = GetFilmFilterImplementation(repository);

  test('Must return an FilmFilter entity on success', () async {
    when(() => repository()).thenAnswer((invocation) async => Right(FilmFilterFake()));

    final result = await usecase();

    expect(result.fold(id, id), isA<FilmFilter>());
  });
  test('Must return FilmFilterFailure on failure', () async {
    when(() => repository()).thenAnswer((invocation) async => Left((FilmFilterFailure(message: 'Erro'))));

    final result = await usecase();

    expect(result.fold(id, id), isA<FilmFilterFailure>());
  });
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/repositories/search_movies_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/usecase/get_search_movie.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/validators/search_movies_validators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchMoviesRepositoryMock extends Mock implements SearchMoviesRepository {}

class SearchMoviesParametersMock extends Mock implements SearchMoviesParameters {}

class SearchMoviesListFake extends Fake implements SearchMoviesList {}

void main() {
  final repository = SearchMoviesRepositoryMock();
  final validator = SearchMoviesValidatorsImplementation();
  final usecase = GetSearchMoviesImplementation(repository, validator);
  // final parameters = SearchMoviesParametersMock();

  setUp(() {
    registerFallbackValue(SearchMoviesParametersMock);
  });

  final parameters = SearchMoviesParameters('lala');

  test('Must return SearchMoviesList on success ', () async {
    when(() => repository(parameters)).thenAnswer((invocation) async => Right(SearchMoviesListFake()));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<SearchMoviesList>());
  });
  test('Must return SearchMoviesFailure on failure ', () async {
    when(() => repository(parameters)).thenAnswer((invocation) async => Left(SearchMoviesFailure('erro')));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<SearchMoviesFailure>());
  });
}

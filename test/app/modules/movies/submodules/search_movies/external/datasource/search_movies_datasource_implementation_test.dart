import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/external/datasource/search_movies_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/search_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/models/search_movies_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/search_movies_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class SearchMoviesParametersMock extends Mock implements SearchMoviesParameters {}

class RequestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = SearchMoviesDatasourceImplementation(dio);

  final parameters = SearchMoviesParameters('homem');

  setUp(() {
    registerFallbackValue(SearchMoviesParametersMock());
  });

  test('Must return an SearchMoviesListModel on status code 200', () async {
    when(() => dio.get(
          any(),
        )).thenAnswer((invocation) async => Response(
          data: searchMoviesSucessResponse,
          statusCode: 200,
          requestOptions: RequestOptionsFake(),
        ));

    final result = await datasource(parameters);

    expect(result, isA<SearchMoviesListModel>());
  });

  test('Must throw an SearchMoviesDatasourceError on any other status code', () async {
    when(() => dio.get(
          any(),
        )).thenAnswer((invocation) async => Response(
          statusCode: 500,
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource(parameters);

    expect(result, throwsA(isA<SearchMoviesDatasourceError>()));
  });

  test('Must throw Exception on dio error', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource(parameters);

    expect(result, throwsA(isA<Exception>()));
  });
}

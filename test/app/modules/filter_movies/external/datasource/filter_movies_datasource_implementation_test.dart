import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/external/datasource/filter_movies_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/infrastructure/errors/filter_movies_datasource_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/filter_movies_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class ResquestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = FilterMoviesDatasourceImplementation(dio);

  test('Must return a MoviesList on status code 200', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: filterMoviesSucessResponse,
          statusCode: 200,
          requestOptions: ResquestOptionsFake(),
        ));

    final result = await datasource();

    expect(result, isA<FilterMovies>());
  });

  test('Must throw an MoviesListDatasourceError on any other status code', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: '',
          statusCode: 400,
          requestOptions: ResquestOptionsFake(),
        ));

    final result = datasource();

    expect(result, throwsA(isA<FilterMoviesDatasourceError>()));
  });

  test('Must throw an Exception on dio error ', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource();

    expect(result, throwsA(isA<Exception>()));
  });
}

import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/external/datasource/genres_list_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/infrastructure/errors/genres_list_datasource_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/genres_list_success_response.dart';

class DioMock extends Mock implements Dio {}

class ResquestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = GenresListDatasourceImplementation(dio);

  test('Must return a MoviesList on status code 200', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: genresListSuccessResponse,
          statusCode: 200,
          requestOptions: ResquestOptionsFake(),
        ));

    final result = await datasource();

    expect(result, isA<GenresList>());
  });

  test('Must throw a MoviesListDatasourceError on any other status code', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: '',
          statusCode: 400,
          requestOptions: ResquestOptionsFake(),
        ));

    final result = datasource();

    expect(result, throwsA(isA<GenresListDatasourceError>()));
  });

  test('Must throw an Exception on dio error ', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource();

    expect(result, throwsA(isA<Exception>()));
  });
}

import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/external/datasource/movies_list_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/errors/movies_list_datasource_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mock/movies_list_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class RequestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = MoviesListDatasourceImplementation(dio);

  test('Must return a MoviesList on status code 200', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: moviesListSucessResponse,
          statusCode: 200,
          requestOptions: RequestOptionsFake(),
        ));

    final result = await datasource();

    expect(result, isA<MoviesList>());
  });

  test('Must throw an MoviesListDatasourceError on any other status code', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: '',
          statusCode: 400,
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource();

    expect(result, throwsA(isA<MoviesListDatasourceError>()));
  });

  test('Must throw an Exception on dio error ', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource();

    expect(result, throwsA(isA<Exception>()));
  });
}

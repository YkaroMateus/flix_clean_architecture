import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/external/datasource/most_popular_movies_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/infrastructure/errors/most_popular_movies_datasource_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mock/most_popular_movies_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class RequestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = MostPopularMoviesDatasourceImplementation(dio);

  test('Must return a MoviesList on status code 200', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: mostPopularMoviesSucessResponse,
          statusCode: 200,
          requestOptions: RequestOptionsFake(),
        ));

    final result = await datasource();

    expect(result, isA<MoviesList>());
  });

  test('Must throw an MostPopularMoviesDatasourceError on any other status code', () async {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
          data: '',
          statusCode: 400,
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource();

    expect(result, throwsA(isA<MostPopularMoviesDatasourceError>()));
  });

  test('Must throw an Exception on dio error ', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource();

    expect(result, throwsA(isA<Exception>()));
  });
}

import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/domain/movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genre.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/external/datasource/movies_by_genres_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/infrastructure/errors/movies_by_genres_datasource_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/movies_by_genres_success_response.dart';

class DioMock extends Mock implements Dio {}

class MoviesByGenresParametersMock extends Mock implements MoviesByGenresParameters {}

class RequestOptionsFake extends Fake implements RequestOptions {}

void main() {
  final dio = DioMock();
  final datasource = MoviesByGenresDatasourceImplementation(dio);

    final parameters = MoviesByGenresParameters(Genre(id: -1, name: ''));


  setUp(() {
    registerFallbackValue(MoviesByGenresParametersMock());
  });

  test('Must return an MoviesByGenresListModel on status code 200', () async {
    when(() => dio.get(
          any(),
        )).thenAnswer((invocation) async => Response(
          data: moviesByGenresSucessResponse,
          statusCode: 200,
          requestOptions: RequestOptionsFake(),
        ));

    final result = await datasource(parameters);

    expect(result, isA<MoviesList>());
  });

  test('Must throw an MoviesByGenresDatasourceError on any other status code', () async {
    when(() => dio.get(
          any(),
        )).thenAnswer((invocation) async => Response(
          statusCode: 500,
          requestOptions: RequestOptionsFake(),
        ));

    final result = datasource(parameters);

    expect(result, throwsA(isA<MoviesByGenresDatasourceError>()));
  });

  test('Must throw Exception on dio error', () async {
    when(() => dio.get(any())).thenThrow(Exception());

    final result = datasource(parameters);

    expect(result, throwsA(isA<Exception>()));
  });
}

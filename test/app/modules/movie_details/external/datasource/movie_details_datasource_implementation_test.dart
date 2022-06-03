import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/external/datasource/movie_details_datasource_implementation.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/errors/movie_details_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/models/movie_details_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/movies_details_sucess_response.dart';

class DioMock extends Mock implements Dio {}

class ResquestOptionsFake extends Fake implements RequestOptions {}

class MovieDetailsParametersMock extends Mock implements MovieDetailsParameters {}

void main() {
  setUp(() {
    registerFallbackValue(MovieDetailsParametersMock());
    registerFallbackValue(ResquestOptionsFake());
  });
  final dio = DioMock();
  final datasource = MovieDetailsDatasourceImplementation(dio);
  final parameters = MovieDetailsParametersMock();

  test("Must return an MovieDetailsModel on status code 200", () async {
    when((() => dio.get(
              any(),
            )))
        .thenAnswer((invocation) async => Response(
            data: movieDetailsSucessRresponse, statusCode: 200, requestOptions: ResquestOptionsFake()));

    final response = await datasource(parameters);
    expect(response, isA<MovieDetailsModel>());
  });
  test('Must return an MovieDetailsDatasourceError on any other status code', () async {
    when((() => dio.get(any()))).thenAnswer(
        (invocation) async => Response(data: '', statusCode: 400, requestOptions: ResquestOptionsFake()));

    final result = datasource(parameters);
    expect(result, throwsA(isA<MovieDetailsDatasourceError>()));
  });
  test('Must throw Exception on dio error ', () async {
    when((() => dio.get(any()))).thenThrow(Exception());

    final result = datasource(parameters);
    expect(result, throwsA(isA<Exception>()));
  });
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/failures/movie_details_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/datasource/movie_details_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/errors/movie_details_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/models/movie_details_model.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/infrastructure/repositories/movie_details_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MovieDetailsDatasourceMock extends Mock implements MovieDetailsDatasource {}

class MovieDetailsModelFake extends Fake implements MovieDetailsModel {}

class MovieDetailsParametersMock extends Mock implements MovieDetailsParameters {}

void main() {
  setUp(() {
    registerFallbackValue(MovieDetailsParametersMock());
  });

  final datasource = MovieDetailsDatasourceMock();
  final repository = MovieDetailsRepositoryImplementation(datasource);
  final parameters = MovieDetailsParametersMock();

  test('Must return an MostPopularMoviesModel on success', () async {
    when(() => datasource(parameters)).thenAnswer((invocation) async => MovieDetailsModelFake());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MovieDetailsModel>());
  });

  test('Must return an MovieDetailsFailure on MovieDetailsDatasourceError', () async {
    when(() => datasource(parameters)).thenThrow(MovieDetailsDatasourceError(message: 'erro'));

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MovieDetailsFailure>());
  });

  test('Must return an MovieDetailsFailure on Exception', () async {
    when(() => datasource(parameters)).thenThrow(Exception());

    final result = await repository(parameters);

    expect(result.fold(id, id), isA<MovieDetailsFailure>());
  });
}

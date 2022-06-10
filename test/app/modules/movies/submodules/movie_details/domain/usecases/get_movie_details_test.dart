import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/failures/movie_details_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/usecases/get_movie_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MovieDetailsRepositoryMock extends Mock implements MovieDetailsRepository {}

class MovieDetailsFake extends Fake implements MovieDetails {}

class MovieDetailsParametersMock extends Mock implements MovieDetailsParameters {}

void main() {
  setUp(() {
    registerFallbackValue(MovieDetailsParametersMock());
  });

  final repository = MovieDetailsRepositoryMock();
  final usecase = GetMovieDetailsImplementation(repository);

  final parameters = MovieDetailsParameters(123);

  test('Must return an MovieDetails entity on success', () async {
    when(() => repository(any())).thenAnswer((invocation) async => Right(MovieDetailsFake()));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<MovieDetails>());
  });

  test('Must return MovieDetailsFailure on Failure', () async {
    when(() => repository(any()))
        .thenAnswer((invocation) async => Left(MovieDetailsFailure(message: 'Ocorreu um erro!')));

    final result = await usecase(parameters);

    expect(result.fold(id, id), isA<MovieDetailsFailure>());
  });
}

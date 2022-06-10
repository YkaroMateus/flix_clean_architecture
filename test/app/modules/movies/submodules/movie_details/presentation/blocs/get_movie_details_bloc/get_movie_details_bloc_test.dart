import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/failures/movie_details_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/usecases/get_movie_details.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/events/get_movie_details_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/movie_details_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieDetailsMock extends Mock implements GetMovieDetails {}

class MovieDetailsParametersMock extends Mock implements MovieDetailsParameters {}

class MovieDetailsFake extends Fake implements MovieDetails {}

void main() {
  setUp(() {
    registerFallbackValue(MovieDetailsParametersMock());
  });

  final usecase = GetMovieDetailsMock();
  final bloc = MovieDetailsBloc(usecase);

  final parameters = MovieDetailsParameters(123);

  test("Must emit all states in order on success", () async {
    when(() => usecase(any())).thenAnswer((invocation) async => Right(MovieDetailsFake()));

    bloc.add(GetMovieDetailsEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMovieDetailsLoadingState>(),
          isA<GetMovieDetailsSucessState>(),
        ]));
  });
  test("Must emit all states in order on ImageOfTheDayFailure failure", () async {
    when(() => usecase(any())).thenAnswer((invocation) async => Left(MovieDetailsFailure(message: 'erro')));

    bloc.add(GetMovieDetailsEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMovieDetailsLoadingState>(),
          isA<GetMovieDetailsFailureState>(),
        ]));
  });
}

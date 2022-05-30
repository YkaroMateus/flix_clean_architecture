import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/movie_details/domain/entites/movie_details.dart';
import 'package:flix_clean_ark/app/module/movie_details/domain/failures/movie_details_failure.dart';
import 'package:flix_clean_ark/app/module/movie_details/domain/usecases/get_movie_details.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/events/get_movie_details_event.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/get_movie_details_bloc.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_failure_state.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieDetailsMock extends Mock implements GetMovieDetails {}

class MovieDetailsFake extends Fake implements MovieDetails {}

void main() {
  final usecase = GetMovieDetailsMock();
  final bloc = GetMovieDetailsBloc(usecase);

  test("Must emit all states in order on success", () async {
    when(() => usecase()).thenAnswer((invocation) async => Right(MovieDetailsFake()));

    bloc.add(GetMovieDetailsEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMovieDetailsLoadingState>(),
          isA<GetMovieDetailsSucessState>(),
        ]));
  });
  test("Must emit all states in order on ImageOfTheDayFailure failure", () async {
    when(() => usecase()).thenAnswer((invocation) async => Left(MovieDetailsFailure(message: 'erro')));

    bloc.add(GetMovieDetailsEvent());

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetMovieDetailsLoadingState>(),
          isA<GetMovieDetailsFailureState>(),
        ]));
  });
}

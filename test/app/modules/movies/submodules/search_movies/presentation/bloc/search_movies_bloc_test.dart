import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/usecase/get_search_movie.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/events/search_movies_parameters_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_search_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_search_movies_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/get_serach_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetSearchMovieMock extends Mock implements GetSearchMovie {}

class SearchMoviesListFake extends Fake implements SearchMoviesList {}

class SearchMoviesParametersMock extends Mock implements SearchMoviesParameters {}

void main() {
  final usecase = GetSearchMovieMock();
  final bloc = SearchMoviesBloc(usecase);

  final parameters = SearchMoviesParameters('alal');

  setUp(() {
    registerFallbackValue(SearchMoviesParametersMock());
  });

  test('Must emit all states in order on success', () async {
    when(() => usecase(any())).thenAnswer((invocation) async => Right(SearchMoviesListFake()));

    bloc.add(SearchMoviesParametersEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetSearchMoviesLoadingState>(),
          isA<GetSearchMoviesSucessState>(),
        ]));
  });
  test('Must emit all states in order on failure', () async {
    when(() => usecase(any())).thenAnswer((invocation) async => Left(SearchMoviesFailure('erro')));

    bloc.add(SearchMoviesParametersEvent(parameters));

    expect(
        bloc.stream,
        emitsInOrder([
          isA<GetSearchMoviesLoadingState>(),
          isA<GetSearchMoviesFailureState>(),
        ]));
  });
}

import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/most_popular_movies_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/pages/most_popular_movie_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'domain/usecases/get_most_popular_movies.dart';
import 'external/datasource/most_popular_movies_datasource_implementation.dart';
import 'infrastructure/repositories/most_popular_movies_repository_implementation.dart';

class MostPopularMoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetMostPopularMoviesImplementation(i())),
    Bind((i) => MostPopularMoviesRepositoryImplementation(i())),
    Bind((i) => MostPopularMoviesDatasourceImplementation(i())),
    Bind((i) => MostPopularMoviesBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => MostPopularMoviesHomePage()),
  ];
}

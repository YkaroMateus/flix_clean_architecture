import 'package:flutter_modular/flutter_modular.dart';

import '../genres_list/domain/usecases/get_genres_list.dart';
import '../genres_list/external/datasource/genres_list_datasource_implementation.dart';
import '../genres_list/infrastructure/repositories/genres_list_repository_implementation.dart';
import '../genres_list/presentation/blocs/dropdown_selection_bloc/dropdown_selection_bloc.dart';
import '../genres_list/presentation/blocs/genres_list_bloc/genres_list_bloc.dart';
import '../movies_by_genres/domain/usecases/get_movies_by_genres.dart';
import '../movies_by_genres/external/datasource/movies_by_genres_datasource_implementation.dart';
import '../movies_by_genres/infrastructure/repositories/movies_by_genres_repository_implementation.dart';
import '../movies_by_genres/presentation/bloc/movies_by_genres_bloc/movies_by_genres_bloc.dart';
import '../search_movies/domain/usecase/get_search_movie.dart';
import '../search_movies/domain/validators/search_movies_validators.dart';
import '../search_movies/external/datasource/search_movies_datasource_implementation.dart';
import '../search_movies/infrastructure/repositories/search_movies_repository_implementation.dart';
import '../search_movies/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'domain/usecases/get_most_popular_movies.dart';
import 'external/datasource/most_popular_movies_datasource_implementation.dart';
import 'infrastructure/repositories/most_popular_movies_repository_implementation.dart';
import 'presentation/blocs/most_popular_movies_bloc/most_popular_movies_bloc.dart';
import 'presentation/pages/most_popular_movie_home_page.dart';

class MostPopularMoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetMostPopularMoviesImplementation(i())),
    Bind((i) => MostPopularMoviesRepositoryImplementation(i())),
    Bind((i) => MostPopularMoviesDatasourceImplementation(i())),
    Bind((i) => MostPopularMoviesBloc(i())),
    //
    Bind((i) => GetSearchMoviesImplementation(i(), i())),
    Bind((i) => SearchMoviesValidatorsImplementation()),
    Bind((i) => SearchMoviesRepositoryImplementation(i())),
    Bind((i) => SearchMoviesDatasourceImplementation(i())),
    Bind((i) => SearchMoviesBloc(i())),
    //
    Bind((i) => GetGenresListImplementation(i())),
    Bind((i) => GenresListRepositoryImplementation(i())),
    Bind((i) => GenresListDatasourceImplementation(i())),
    Bind((i) => GenresListBloc(i())),
    //
    Bind((i) => GetMoviesByGenresImplementation(i())),
    Bind((i) => MoviesByGenresRepositoryImplementation(i())),
    Bind((i) => MoviesByGenresDatasourceImplementation(i())),
    Bind((i) => MoviesByGenresBloc(i())),
    //
    Bind((i) => DropdownSelectionBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => MostPopularMoviesHomePage()),
  ];
}

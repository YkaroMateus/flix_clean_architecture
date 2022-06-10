import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/filter_movies_module.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/movie_details_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/routes/routes.dart';
import 'submodules/most_popular_movies/most_popular_movies_module.dart';

class MoviesModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.mostPopularMovies, module: MostPopularMoviesModule()),
    ModuleRoute(Routes.movieDetails, module: MovieDetailsModule()),
    ModuleRoute(Routes.filterMovies, module: FilterMoviesModule()),
  ];
}

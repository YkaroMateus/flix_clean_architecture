import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/most_popular_movies_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/MostPopularMoviesModule", module: MostPopularMoviesModule()),
  ];
}

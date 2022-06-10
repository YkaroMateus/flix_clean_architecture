import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/core/routes/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'movies/movie_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.movies, module: MoviesModule()),
  ];
}

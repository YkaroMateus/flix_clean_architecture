import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'most_popular_movies/presentation/pages/most_popular_movie_home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/MostPopularMoviesModule", child: (context, args) => MostPopularMoviesHomePage()),
  ];
}

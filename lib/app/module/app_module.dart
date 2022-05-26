import 'package:flix_clean_ark/app/module/most_popular_movies/presenter/pages/most_popular_movie_home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => MostPopularMoviesHomePage()),
  ];
}

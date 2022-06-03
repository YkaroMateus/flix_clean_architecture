import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'domain/usecases/get_movies_list.dart';
import 'external/datasource/movies_list_datasource_implementation.dart';
import 'infrastructure/repositories/movies_list_repository_implementation.dart';

class MostPopularMoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetMoviesListImplementation(i())),
    Bind((i) => MoviesListRepositoryImplementation(i())),
    Bind((i) => MoviesListDatasourceImplementation(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => SizedBox()),
  ];
}

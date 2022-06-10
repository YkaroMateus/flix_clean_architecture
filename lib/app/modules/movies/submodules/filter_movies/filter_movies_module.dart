import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/blocs/get_filter_movies/get_filter_movies_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/filter_movies/presentation/widgets/filter_movies_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_filter_movies.dart';
import 'external/datasource/filter_movies_datasource_implementation.dart';
import 'infrastructure/repositories/filter_movies_repository_implementation.dart';

class FilterMoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetFilterMoviesImplementation(i())),
    Bind((i) => FilterMoviesRepositoryImplementation(i())),
    Bind((i) => FilterMoviesDatasourceImplementation(i())),
    Bind((i) => GetFilterMoviesBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => FilterMoviesWidget()),
  ];
}

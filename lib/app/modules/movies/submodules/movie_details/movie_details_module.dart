import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/get_movie_details_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/pages/movie_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_movie_details.dart';
import 'external/datasource/movie_details_datasource_implementation.dart';
import 'infrastructure/repositories/movie_details_repository_implementation.dart';

class MovieDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetMovieDetailsImplementation(i())),
    Bind((i) => MovieDetailsRepositoryImplementation(i())),
    Bind((i) => MovieDetailsDatasourceImplementation(i())),
    Bind((i) => GetMovieDetailsBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => MovieDetailsPage(id: args.data[0])),
  ];
}

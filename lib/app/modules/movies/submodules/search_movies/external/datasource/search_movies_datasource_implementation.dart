import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/core/configuration/config.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/external/settings/search_movies_settings.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/datasource/search_movies_datasource.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/models/search_movies_list_model.dart';
import 'package:flix_clean_ark/app/secrets.dart';

import '../../infrastructure/errors/search_movies_datasource_error.dart';

class SearchMoviesDatasourceImplementation implements SearchMoviesDatasource {
  final Dio dio;

  SearchMoviesDatasourceImplementation(this.dio);

  @override
  Future<SearchMoviesList> call(SearchMoviesParameters parameters) async {
    final response =
        await dio.get("${Config.baseUrl}${SearchMoviesSettings.endpoint}${Secrets.apiKey}&query=$parameters");

    if (response.statusCode == 200) {
      return SearchMoviesListModel.fromJson(response.data);
    } else {
      throw SearchMoviesDatasourceError('Ocorreu um erro!');
    }
  }
}

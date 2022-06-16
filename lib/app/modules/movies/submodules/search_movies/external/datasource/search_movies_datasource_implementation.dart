import 'package:dio/dio.dart';

import '../../../../../../core/configuration/config.dart';
import '../../../../../../secrets.dart';
import '../../../../domain/movies_list.dart';
import '../../../../infrastructure/models/movies_list_model.dart';
import '../../domain/entites/search_movies_parameters.dart';
import '../../infrastructure/datasource/search_movies_datasource.dart';
import '../../infrastructure/errors/search_movies_datasource_error.dart';
import '../settings/search_movies_settings.dart';

class SearchMoviesDatasourceImplementation implements SearchMoviesDatasource {
  final Dio dio;

  SearchMoviesDatasourceImplementation(this.dio);

  @override
  Future<MoviesList> call(SearchMoviesParameters parameters) async {
    final response = await dio.get(
        '${Config.baseUrl}${SearchMoviesSettings.endpoint}?api_key=${Secrets.apiKey}&query=${parameters.query}');
    if (response.statusCode == 200) {
      return MoviesListModel.fromJson(response.data);
    } else {
      throw SearchMoviesDatasourceError('Ocorreu um erro!');
    }
  }
}

import 'package:dio/dio.dart';

import '../../../../../../core/configuration/config.dart';
import '../../../../../../secrets.dart';
import '../../../../domain/movies_list.dart';
import '../../../../infrastructure/models/movies_list_model.dart';
import '../../domain/entities/movies_by_genres_parameters.dart';
import '../../infrastructure/datasource/movies_by_genres_datasource.dart';
import '../../infrastructure/errors/movies_by_genres_datasource_error.dart';
import '../settings/movies_by_genres_settings.dart';

class MoviesByGenresDatasourceImplementation implements MoviesByGenresDatasource {
  final Dio dio;

  MoviesByGenresDatasourceImplementation(this.dio);

  @override
  Future<MoviesList> call(MoviesByGenresParameters parameters) async {
    final response = await dio.get(
        '${Config.baseUrl}${MoviesByGenresSettings.endpoint}?api_key=${Secrets.apiKey}&with_genres=${parameters.genre.id}');

    if (response.statusCode == 200) {
      return MoviesListModel.fromJson(response.data);
    } else {
      throw MoviesByGenresDatasourceError('Ocorreu um erro interno!');
    }
  }
}

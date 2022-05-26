import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/external/settings/most_popular_movies_settings.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/datasource/most_popular_movie_datasource.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/errors/most_popular_movies_datasource_error.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/models/most_popular_movies_model.dart';
import 'package:flix_clean_ark/secrets.dart';

import '../../../../core/configuration/config.dart';

class MostPopularMoviesDatasourceImplementation implements MostPopularMoviesDatasource {
  final Dio dio;
  MostPopularMoviesDatasourceImplementation(this.dio);

  @override
  Future<MostPopularMoviesModel> call() async {
    final response =
        await dio.get('${Config.baseUrl}${MostPopularMoviesSettings.endpoint}?api_key=${Secrets.apiKey}');

    if (response.statusCode == 200) {
      return MostPopularMoviesModel.fromJson(response.data);
    } else {
      throw MostPopularMoviesDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/secrets.dart';
import '../../../../../../core/configuration/config.dart';
import '../../../../domain/movies_list.dart';
import '../../infrastructure/datasource/most_popular_movies_datasource.dart';
import '../../infrastructure/errors/most_popular_movies_datasource_error.dart';
import '../../../../infrastructure/models/movies_list_model.dart';
import '../settings/most_popular_movies_settings.dart';

class MostPopularMoviesDatasourceImplementation implements MostPopularMoviesDatasource {
  final Dio dio;

  MostPopularMoviesDatasourceImplementation(this.dio);

  @override
  Future<MoviesList> call() async {
    final response =
        await dio.get('${Config.baseUrl}${MostPopularMoviesSettings.endpoint}?api_key=${Secrets.apiKey}');

    if (response.statusCode == 200) {
      return MoviesListModel.fromJson(response.data);
    } else {
      throw MostPopularMoviesDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

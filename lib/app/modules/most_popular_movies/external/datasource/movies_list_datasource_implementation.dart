import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/external/settings/movies_list_settings.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/datasource/movies_list_datasource.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/errors/movies_list_datasource_error.dart';
import 'package:flix_clean_ark/secrets.dart';
import '../../../../core/configuration/config.dart';
import '../../domain/entites/movies_list.dart';
import '../../infrastructure/models/movies_list_model.dart';

class MoviesListDatasourceImplementation implements MoviesListDatasource {
  final Dio dio;

  MoviesListDatasourceImplementation(this.dio);

  @override
  Future<MoviesList> call() async {
    final response =
        await dio.get('${Config.baseUrl}${MoviesListSettings.endpoint}?api_key=${Secrets.apiKey}');
    if (response.statusCode == 200) {
      return MoviesListModel.fromJson(response.data);
    } else {
      throw MoviesListDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

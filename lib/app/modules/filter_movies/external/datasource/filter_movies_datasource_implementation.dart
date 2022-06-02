import 'package:dio/dio.dart';

import '../../../../../secrets.dart';
import '../../../../core/configuration/config.dart';
import '../../domain/entites/filter_movies.dart';
import '../../infrastructure/datasource/filter_movies_datasource.dart';
import '../../infrastructure/errors/filter_movies_datasource_error.dart';
import '../../infrastructure/models/filter_movies_model.dart';
import '../settings/filter_movies_settings.dart';

class FilterMoviesDatasourceImplementation implements FilterMoviesDatasource {
  final Dio dio;

  FilterMoviesDatasourceImplementation(this.dio);

  @override
  Future<FilterMovies> call() async {
    final response =
        await dio.get('${Config.baseUrl}${FilterMoviesSettings.endpoint}?api_key=${Secrets.apiKey}');
    if (response.statusCode == 200) {
      return FilterMoviesModel.fromJson(response.data);
    } else {
      throw FilterMoviesDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

import 'package:dio/dio.dart';
import '../../../../../../core/configuration/config.dart';
import '../../../../../../secrets.dart';
import '../../domain/entites/movie_details.dart';
import '../../domain/entites/movie_details_parameters.dart';
import '../../infrastructure/datasource/movie_details_datasource.dart';
import '../../infrastructure/errors/movie_details_datasource_error.dart';
import '../../infrastructure/models/movie_details_model.dart';
import '../settings/movie_details_settings.dart';

class MovieDetailsDatasourceImplementation implements MovieDetailsDatasource {
  final Dio dio;

  MovieDetailsDatasourceImplementation(this.dio);
  @override
  Future<MovieDetails> call(MovieDetailsParameters parameters) async {
    final response = await dio
        .get('${Config.baseUrl}${MovieDetailsSettings.endpoint}/${parameters.id}?api_key=${Secrets.apiKey}');

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw MovieDetailsDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

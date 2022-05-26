import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/module/movie_details/external/datasource/settings/movie_details_settings.dart';
import '../../../../../secrets.dart';
import '../../../../core/configuration/config.dart';
import '../../infrastructure/datasource/movie_details_datasource.dart';
import '../../infrastructure/errors/movie_details_datasource_error.dart';
import '../../infrastructure/models/movie_details_model.dart';

class MovieDetailsDatasourceImplementation implements MovieDetailsDatasource {
  final Dio dio;

  MovieDetailsDatasourceImplementation(this.dio);
  @override
  Future<MovieDetailsModel> call() async {
    final response =
        await dio.get('${Config.baseUrl}${MovieDetailsSettings.endpoint}?api_key=${Secrets.apiKey}');

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw MovieDetailsDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';
import '../../../../../../core/configuration/config.dart';
import '../../../../../../secrets.dart';
import '../../infrastructure/datasource/genres_list_datasource.dart';
import '../../infrastructure/errors/genres_list_datasource_error.dart';
import '../../infrastructure/models/genres_list_model.dart';
import '../settings/genres_list_settings.dart';

class GenresListDatasourceImplementation implements GenresListDatasource {
  final Dio dio;

  GenresListDatasourceImplementation(this.dio);

  @override
  Future<GenresList> call() async {
    final response =
        await dio.get('${Config.baseUrl}${GenresListSettings.endpoint}?api_key=${Secrets.apiKey}');

    if (response.statusCode == 200) {
      return GenresListModel.fromJson(response.data);
    } else {
      throw GenresListDatasourceError(message: 'Ocorreu um erro interno!');
    }
  }
}

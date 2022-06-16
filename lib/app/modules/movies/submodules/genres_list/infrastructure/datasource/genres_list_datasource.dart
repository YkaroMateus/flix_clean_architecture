import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/domain/entites/genres_list.dart';

abstract class GenresListDatasource {
  Future<GenresList> call();
}

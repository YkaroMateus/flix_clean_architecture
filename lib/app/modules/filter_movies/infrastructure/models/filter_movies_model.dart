import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';

class FilterMoviesModel extends FilterMovies {
  FilterMoviesModel({
    required int id,
    required String name,
  }) : super(id: id, name: name);

  static FilterMoviesModel fromJson(Map<String, dynamic> json) {
    return FilterMoviesModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
    );
  }
}

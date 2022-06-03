import '../../domain/entites/filter_movies.dart';
import '../../domain/entites/filter_movies_list.dart';
import 'filter_movies_model.dart';

class FilterMoviesListModel extends FilterMoviesList {
  final List<FilterMovies> genreList;
  FilterMoviesListModel({required this.genreList}) : super(genreList: genreList);

  static FilterMoviesListModel fromJson(Map<String, dynamic> json) {
    return FilterMoviesListModel(
      genreList: ((json['genres'] ?? []) as List)
          .map(
            (element) => FilterMoviesModel.fromJson(element),
          )
          .toList(),
    );
  }
}

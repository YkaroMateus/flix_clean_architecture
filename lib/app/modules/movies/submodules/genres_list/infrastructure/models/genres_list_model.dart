import '../../domain/entites/genre.dart';
import '../../domain/entites/genres_list.dart';
import 'genre_model.dart';

class GenresListModel extends GenresList {
  final List<Genre> genresList;
  GenresListModel({required this.genresList}) : super(genresList: genresList);

  static GenresListModel fromJson(Map<String, dynamic> json) {
    return GenresListModel(
      genresList: ((json['genres'] ?? []) as List)
          .map(
            (element) => GenreModel.fromJson(element),
          )
          .toList(),
    );
  }
}

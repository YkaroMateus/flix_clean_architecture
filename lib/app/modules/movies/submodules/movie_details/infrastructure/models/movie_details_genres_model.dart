import '../../domain/entites/movie_details_genres.dart';

class MovieDetailsGenresModel extends MovieDetailsGenres {
  final int id;
  final String name;

  MovieDetailsGenresModel({required this.id, required this.name}) : super(id: id, name: name);
  static MovieDetailsGenresModel fromJson(Map<String, dynamic> json) {
    return MovieDetailsGenresModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
    );
  }
}

import '../../domain/entites/genre.dart';

class GenreModel extends Genre {
  GenreModel({
    required int id,
    required String name,
  }) : super(id: id, name: name);

  static GenreModel fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
    );
  }
}

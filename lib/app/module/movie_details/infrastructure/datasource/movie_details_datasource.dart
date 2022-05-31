import '../models/movie_details_model.dart';

abstract class MovieDetailsDatasource {
  Future<MovieDetailsModel> call();
}

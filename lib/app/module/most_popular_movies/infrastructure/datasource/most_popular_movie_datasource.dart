import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/models/most_popular_movies_model.dart';

abstract class MostPopularMoviesDatasource {
  Future<MostPopularMoviesModel> call();
}

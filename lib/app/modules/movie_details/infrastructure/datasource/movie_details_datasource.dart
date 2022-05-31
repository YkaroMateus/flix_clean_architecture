import 'package:flix_clean_ark/app/modules/movie_details/domain/entites/movie_details.dart';

import '../../domain/entites/movie_details_parameters.dart';

abstract class MovieDetailsDatasource {
  Future<MovieDetails> call(MovieDetailsParameters parameters);
}

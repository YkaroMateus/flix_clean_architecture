import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/movie_details.dart';
import '../entites/movie_details_parameters.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, MovieDetails>> call(MovieDetailsParameters parameters);
}

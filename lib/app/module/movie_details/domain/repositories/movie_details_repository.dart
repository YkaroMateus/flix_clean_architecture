import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, MovieDetails>> call();
}

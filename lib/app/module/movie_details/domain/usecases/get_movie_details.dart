import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entites/movie_details.dart';
import '../repositories/movie_details_repository.dart';

abstract class GetMovieDetails {
  Future<Either<Failure, MovieDetails>> call();
}

class GetMovieDetailsImplementation implements GetMovieDetails {
  final MovieDetailsRepository repository;

  GetMovieDetailsImplementation(this.repository);

  @override
  Future<Either<Failure, MovieDetails>> call() async {
    return await repository();
  }
}

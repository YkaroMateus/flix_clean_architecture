import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import 'package:flix_clean_ark/app/modules/movie_details/domain/entites/movie_details.dart';
import 'package:flix_clean_ark/app/modules/movie_details/domain/entites/movie_details_parameters.dart';

import '../repositories/movie_details_repository.dart';

abstract class GetMovieDetails {
  Future<Either<Failure, MovieDetails>> call(MovieDetailsParameters parameters);
}

class GetMovieDetailsImplementation implements GetMovieDetails {
  final MovieDetailsRepository repository;

  GetMovieDetailsImplementation(this.repository);

  @override
  Future<Either<Failure, MovieDetails>> call(MovieDetailsParameters parameters) async {
    return await repository(parameters);
  }
}

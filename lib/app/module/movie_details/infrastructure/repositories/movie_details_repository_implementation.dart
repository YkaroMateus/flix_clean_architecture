import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entites/movie_details.dart';
import '../../domain/failures/movie_details_failure.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../datasource/movie_details_datasource.dart';
import '../errors/movie_details_datasource_error.dart';

class MovieDetailsRepositoryImplementation implements MovieDetailsRepository {
  final MovieDetailsDatasource datasource;

  MovieDetailsRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, MovieDetails>> call() async {
    try {
      return Right(await datasource());
    } on MovieDetailsDatasourceError catch (e) {
      return Left(MovieDetailsFailure(message: e.message));
    } on Exception catch (e) {
      return Left(MovieDetailsFailure(message: e.toString()));
    }
  }
}

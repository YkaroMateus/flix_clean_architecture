import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../domain/movies_list.dart';
import '../../domain/entities/movies_by_genres_parameters.dart';
import '../../domain/failures/movies_by_genres_failure.dart';
import '../../domain/repositories/movies_by_genres_repository.dart';
import '../datasource/movies_by_genres_datasource.dart';
import '../errors/movies_by_genres_datasource_error.dart';

class MoviesByGenresRepositoryImplementation implements MoviesByGenresRepository {
  final MoviesByGenresDatasource datasource;

  MoviesByGenresRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, MoviesList>> call(MoviesByGenresParameters parameters) async {
    try {
      return Right(await datasource(parameters));
    } on MoviesByGenresDatasourceError catch (e) {
      return Left(MoviesByGenresFailure(e.message));
    } on Exception {
      return Left(MoviesByGenresFailure('Ocorreu um erro interno!'));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/failures/movies_list_failure.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/errors/movies_list_datasource_error.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/repositories/movies_list_repository.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/datasource/movies_list_datasource.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entites/movies_list.dart';

class MoviesListRepositoryImplementation implements MoviesListRepository {
  final MoviesListDatasource datasource;

  MoviesListRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, MoviesList>> call() async {
    try {
      return Right(await datasource());
    } on MoviesListDatasourceError catch (e) {
      return Left(MoviesListFailure(message: e.message));
    } on Exception catch (e) {
      return Left(MoviesListFailure(message: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../../domain/entites/movies_list.dart';
import '../../domain/failures/movies_list_failure.dart';
import '../../domain/repositories/movies_list_repository.dart';
import '../datasource/movies_list_datasource.dart';
import '../errors/movies_list_datasource_error.dart';

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

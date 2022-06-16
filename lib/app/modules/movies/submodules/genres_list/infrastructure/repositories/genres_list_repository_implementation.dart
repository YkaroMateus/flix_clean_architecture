import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/core/errors/failure.dart';
import '../../domain/entites/genres_list.dart';
import '../../domain/failures/genres_list_failure.dart';
import '../../domain/repositories/genres_list_repository.dart';
import '../datasource/genres_list_datasource.dart';
import '../errors/genres_list_datasource_error.dart';

class GenresListRepositoryImplementation implements GenresListRepository {
  final GenresListDatasource datasource;

  GenresListRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failure, GenresList>> call() async {
    try {
      return Right(await datasource());
    } on GenresListDatasourceError catch (e) {
      return Left(GenresListFailure(message: e.message));
    } on Exception catch (e) {
      return Left(GenresListFailure(message: e.toString()));
    }
  }
}

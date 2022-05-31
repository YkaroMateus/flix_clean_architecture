import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/modules/film_filter/domain/repositories/film_filter_repository.dart';
import '../../../../core/errors/failure.dart';
import '../entites/film_filter.dart';

abstract class GetFilmFilter {
  Future<Either<Failure, FilmFilter>> call();
}

class GetFilmFilterImplementation implements GetFilmFilter {
  final FilmFilterRepository repository;

  GetFilmFilterImplementation(this.repository);
  @override
  Future<Either<Failure, FilmFilter>> call() async {
    return await repository();
  }
}

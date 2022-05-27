import 'package:dartz/dartz.dart';
import 'package:flix_clean_ark/app/module/film_filter/domain/entites/film_filter.dart';
import '../../../../core/errors/failure.dart';

abstract class FilmFilterRepository {
  Future<Either<Failure, FilmFilter>> call();
}

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/film_filter.dart';

abstract class FilmFilterRepository {
  Future<Either<Failure, FilmFilter>> call();
}

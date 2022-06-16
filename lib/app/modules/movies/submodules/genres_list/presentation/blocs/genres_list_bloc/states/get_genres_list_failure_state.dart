import '../../../../domain/failures/genres_list_failure.dart';
import 'genres_list_states.dart';

class GetGenresListFailureState implements GenresListStates {
  final GenresListFailure failure;

  GetGenresListFailureState(this.failure);
}

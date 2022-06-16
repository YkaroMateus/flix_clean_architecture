import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DropdownSelectionBloc extends Bloc<String, String> implements Disposable {
  DropdownSelectionBloc() : super('') {
    on<String>(_mapStringToState);
  }

  String dropdownValue = 'Most Popular Movies';

  void _mapStringToState(String event, Emitter<String> emit) {
    dropdownValue = event;

    emit(dropdownValue);
  }

  @override
  void dispose() {
    close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../blocs/get_filter_movies/get_filter_movies_bloc.dart';
import '../blocs/get_filter_movies/states/filter_movies_states.dart';
import '../blocs/get_filter_movies/states/get_filter_movies_loading_state.dart';
import '../blocs/get_filter_movies/states/get_filter_movies_sucess_state.dart';

class FilterMoviesWidget extends StatelessWidget {
  final filterMoviesBloc = Modular.get<GetFilterMoviesBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7),
      child: Center(
        child: BlocBuilder<GetFilterMoviesBloc, FilterMoviesStates>(
          bloc: filterMoviesBloc,
          builder: ((context, state) {
            if (state is GetFilterMoviesLoadingState) {
              return CircularProgressIndicator();
            }
            if (state is GetFilterMoviesSucessState) {
              return Container(
                color: Colors.yellow,
                child: Text(state.filterMovies.name),
              );

              // DropdownButton<String>(
              //     icon: Icon(
              //       Icons.filter_alt,
              //       color: Colors.white,
              //       size: 24,
              //     ),
              //     value: filterMoviesBloc,
              //     onChanged: filterMoviesBloc.add(GetFilterMoviesEvent()),
              //     dropdownColor: Colors.blue,
              //     items: []);
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}

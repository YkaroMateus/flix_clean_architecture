import 'package:flix_clean_ark/app/modules/most_popular_movies/presentation/blocs/get_movies_list/most_popular_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MostPopularMoviesHomePage extends StatefulWidget {
  const MostPopularMoviesHomePage({Key? key}) : super(key: key);

  @override
  State<MostPopularMoviesHomePage> createState() => _ModuleMostPopularMoviesState();
}

class _ModuleMostPopularMoviesState extends State<MostPopularMoviesHomePage> {
  final bloc = Modular.get<MostPopularMoviesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Page'),
            ),
          ),
        ],
      ),
    );
  }
}

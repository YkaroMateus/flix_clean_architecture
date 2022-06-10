import 'dart:io';
import 'package:flix_clean_ark/app/modules/movies/presentation/settings/movie_poster_url.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/events/get_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/states/most_popular_movies_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../blocs/most_popular_movies_bloc/most_popular_movies_bloc.dart';

class MostPopularMoviesHomePage extends StatefulWidget {
  const MostPopularMoviesHomePage();

  @override
  State<MostPopularMoviesHomePage> createState() => _ModuleMostPopularMoviesState();
}

class _ModuleMostPopularMoviesState extends State<MostPopularMoviesHomePage> {
  final mostPopularMoviesBloc = Modular.get<MostPopularMoviesBloc>();

  @override
  void initState() {
    mostPopularMoviesBloc.add(GetMostPopularMoviesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 28, 29),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 100,
                  width: 250,
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png',
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Seja Bem Vindo, Usúario!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Home Page',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                mostPopularMoviesBloc.add(GetMostPopularMoviesEvent());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              title: Text(
                'Sair',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(
            'assets/first_scren-removebg.png',
            height: 60,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              Modular.to.pushNamed('');
            }),
            icon: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: (() {
              Modular.to.pushNamed('/movies/movieDetails/');
            }),
            icon: Icon(
              Icons.filter_list_alt,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.orange,
                  height: 250,
                ),
                Expanded(
                  child: BlocBuilder<MostPopularMoviesBloc, MostPopularMoviesStates>(
                    bloc: mostPopularMoviesBloc,
                    builder: (context, state) {
                      if (state is GetMostPopularMoviesLoadingState) {
                        return Center(child: const CircularProgressIndicator());
                      }

                      if (state is GetMostPopularMoviesSucessState) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            mostPopularMoviesBloc.add(GetMostPopularMoviesEvent());
                          },
                          child: Container(
                            child: ListView.builder(
                              itemCount: state.movieList.movies.length,
                              itemBuilder: (context, position) {
                                return Card(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Color.fromARGB(255, 19, 3, 252).withAlpha(30),
                                    onTap: () {
                                      Modular.to.pushNamed(
                                        '/movies/movieDetails/',
                                        arguments: [
                                          state.movieList.movies[position].id,
                                        ],
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            '${MoviesSettings.moviePosterUrl}${state.movieList.movies[position].poster}',
                                            width: 150,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.52,
                                                  child: Text(
                                                    state.movieList.movies[position].title,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  state.movieList.movies[position].releaseDate,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                SizedBox(height: 7),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.52,
                                                  child: Text(
                                                    state.movieList.movies[position].overview,
                                                    maxLines: 6,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(height: 7),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    ),
                                                    Text(
                                                      state.movieList.movies[position].score,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }

                      if (state is GetMostPopularMoviesFailureState) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(Icons.error, size: 48, color: Colors.white),
                              ),
                              Text(
                                state.failure.message,
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                              ElevatedButton(
                                child: Text('Tentar novamente'),
                                onPressed: () {
                                  mostPopularMoviesBloc.add(
                                    GetMostPopularMoviesEvent(),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

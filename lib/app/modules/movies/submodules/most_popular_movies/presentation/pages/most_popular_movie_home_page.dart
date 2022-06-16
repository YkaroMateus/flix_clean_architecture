import 'dart:io';

import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/infrastructure/models/genre_model.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/genres_list/presentation/blocs/dropdown_selection_bloc/dropdown_selection_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/most_popular_movies_bloc/events/reset_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/get_movies_by_genres_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/movies_by_genres_bloc.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/get_movies_by_genres_success_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/presentation/bloc/movies_by_genres_bloc/states/movies_by_genres_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/movie.dart';
import '../../../../presentation/settings/movie_poster_url.dart';
import '../../../genres_list/domain/entites/genre.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/events/get_genres_list_event.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/genres_list_bloc.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/states/genres_list_states.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_failure_state.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_loading_state.dart';
import '../../../genres_list/presentation/blocs/genres_list_bloc/states/get_genres_list_success_state.dart';
import '../../../movies_by_genres/domain/entities/movies_by_genres_parameters.dart';
import '../../../movies_by_genres/presentation/bloc/movies_by_genres_bloc/events/reset_movies_by_genres_event.dart';
import '../../../search_movies/presentation/bloc/search_movies_bloc/search_movies_bloc.dart';
import '../../../search_movies/presentation/widgets/movies_search_delegate.dart';
import '../blocs/most_popular_movies_bloc/events/get_most_popular_movies_event.dart';
import '../blocs/most_popular_movies_bloc/most_popular_movies_bloc.dart';
import '../blocs/most_popular_movies_bloc/states/get_most_popular_movies_failure_state.dart';
import '../blocs/most_popular_movies_bloc/states/get_most_popular_movies_loading_state.dart';
import '../blocs/most_popular_movies_bloc/states/get_most_popular_movies_sucess_state.dart';
import '../blocs/most_popular_movies_bloc/states/most_popular_movies_states.dart';

class MostPopularMoviesHomePage extends StatefulWidget {
  const MostPopularMoviesHomePage();

  @override
  State<MostPopularMoviesHomePage> createState() => _ModuleMostPopularMoviesState();
}

class _ModuleMostPopularMoviesState extends State<MostPopularMoviesHomePage> {
  
  
  final mostPopularMoviesBloc = Modular.get<MostPopularMoviesBloc>();
  
  
  
  final searchMoviesBloc = Modular.get<SearchMoviesBloc>();
  final genresListBloc = Modular.get<GenresListBloc>();
  final moviesByGenresBloc = Modular.get<MoviesByGenresBloc>();
  final dropdownSelectionBloc = Modular.get<DropdownSelectionBloc>();

  final mostPopularMoviesGenre = GenreModel(id: -1, name: 'Most Popular Movies');

  Genre genre = GenreModel(id: -1, name: 'Most Popular Movies');

  @override
  void initState() {
    mostPopularMoviesBloc.add(GetMostPopularMoviesEvent());
    genresListBloc.add(GetGenresListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 28, 29),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 42, bottom: 16),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png',
                height: 50,
                width: 125,
              ),
            ),
            Text(
              'Seja Bem Vindo, Usúario!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => exit(0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Sair do Aplicativo',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
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
              showSearch(context: context, delegate: MoviesSearchDelegate(searchMoviesBloc));
            }),
            icon: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 10),
            child: BlocBuilder<MoviesByGenresBloc, MoviesByGenresStates>(
              bloc: moviesByGenresBloc,
              builder: (context, moviesByGenresState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(88, 0, 0, 0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      height: 40,
                      width: 100,
                      child: Center(
                        child: BlocBuilder<GenresListBloc, GenresListStates>(
                          bloc: genresListBloc,
                          builder: ((context, state) {
                            if (state is GetGenresListLoadingState) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: LinearProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                            if (state is GetGenresListFailureState) {
                              return Text(
                                state.failure.message,
                                style:
                                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              );
                            }

                            if (state is GetGenresListSuccessState) {
                              if (state.genresList.genresList.first != mostPopularMoviesGenre) {
                                state.genresList.genresList.insert(0, mostPopularMoviesGenre);
                              }

                              return BlocBuilder<DropdownSelectionBloc, String>(
                                bloc: dropdownSelectionBloc,
                                builder: (context, dropdownSelectionState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: DropdownButton<String>(
                                      alignment: Alignment.center,
                                      icon: Icon(
                                        Icons.filter_alt,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          dropdownSelectionBloc.add(newValue);

                                          genre = state.genresList.genresList
                                              .firstWhere((element) => element.name == newValue);

                                          if (genre.id == -1) {
                                            moviesByGenresBloc.add(ResetMoviesByGenresEvent());
                                            mostPopularMoviesBloc.add(GetMostPopularMoviesEvent());
                                          } else {
                                            mostPopularMoviesBloc.add(ResetMostPopularMoviesEvent());
                                            moviesByGenresBloc.add(GetMoviesByGenresEvent(
                                              MoviesByGenresParameters(genre),
                                            ));
                                          }
                                        }
                                      },
                                      value: dropdownSelectionBloc.dropdownValue,
                                      dropdownColor: Colors.blue,
                                      items: state.genresList.genresList.map((Genre genre) {
                                        return DropdownMenuItem(
                                          value: genre.name,
                                          child: Text(
                                            genre.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<MostPopularMoviesBloc, MostPopularMoviesStates>(
                        bloc: mostPopularMoviesBloc,
                        builder: (context, mostPopularMoviesState) {
                          if (mostPopularMoviesState is GetMostPopularMoviesLoadingState ||
                              moviesByGenresState is GetMoviesByGenresLoadingState) {
                            return Center(child: CircularProgressIndicator()

                                // CustomScrollView(
                                //   slivers: [],
                                // ),
                                );
                          }

                          if (mostPopularMoviesState is GetMostPopularMoviesFailureState) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(Icons.error, size: 48, color: Colors.white),
                                  ),
                                  Text(
                                    mostPopularMoviesState.failure.message,
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

                          if (moviesByGenresState is GetMoviesByGenresFailureState) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(Icons.error, size: 48, color: Colors.white),
                                  ),
                                  Text(
                                    moviesByGenresState.failure.message,
                                    style: TextStyle(color: Colors.white, fontSize: 24),
                                  ),
                                  ElevatedButton(
                                    child: Text('Tentar novamente'),
                                    onPressed: () {
                                      moviesByGenresBloc.add(GetMoviesByGenresEvent(
                                        MoviesByGenresParameters(genre),
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            );
                          }

                          if (mostPopularMoviesState is GetMostPopularMoviesSucessState ||
                              moviesByGenresState is GetMoviesByGenresSuccessState) {
                            List<Movie> movies;

                            if (mostPopularMoviesState is GetMostPopularMoviesSucessState) {
                              movies = mostPopularMoviesState.movieList.movies;
                            } else {
                              moviesByGenresState as GetMoviesByGenresSuccessState;
                              movies = moviesByGenresState.moviesByGenres.movies;
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                if (mostPopularMoviesState is GetMostPopularMoviesSucessState) {
                                  movies = mostPopularMoviesState.movieList.movies;
                                } else {
                                  moviesByGenresState as GetMoviesByGenresSuccessState;
                                  movies = moviesByGenresState.moviesByGenres.movies;
                                }
                              },
                              child: Container(
                                child: ListView.builder(
                                  itemCount: movies.length,
                                  itemBuilder: (context, position) {
                                    return Card(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Color.fromARGB(255, 19, 3, 252).withAlpha(30),
                                        onTap: () {
                                          Modular.to.pushNamed(
                                            '/movies/movieDetails/',
                                            arguments: [
                                              movies[position].id,
                                            ],
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                '${MoviesSettings.moviePosterUrl}${movies[position].poster}',
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
                                                        movies[position].title,
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
                                                      movies[position].releaseDate,
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
                                                        movies[position].overview,
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
                                                          movies[position].score,
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

                          return SizedBox();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

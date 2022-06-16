import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entites/search_movies_parameters.dart';
import '../bloc/search_movies_bloc/events/search_movies_event.dart';
import '../bloc/search_movies_bloc/search_movies_bloc.dart';
import '../bloc/search_movies_bloc/states/get_search_movies_loading_state.dart';
import '../bloc/search_movies_bloc/states/get_search_movies_sucess_state.dart';
import '../bloc/search_movies_bloc/states/get_serach_movies_failure_state.dart';
import '../bloc/search_movies_bloc/states/movie_not_found_failure_state.dart';
import '../bloc/search_movies_bloc/states/search_movies_states.dart';

class MoviesSearchDelegate extends SearchDelegate {
  final SearchMoviesBloc searchMoviesBloc;

  MoviesSearchDelegate(this.searchMoviesBloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          size: 25,
          color: Colors.blue,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMoviesBloc.add(SearchMoviesEvent(SearchMoviesParameters(query)));

    return Center(
      child: BlocBuilder<SearchMoviesBloc, SearchMoviesStates>(
        bloc: searchMoviesBloc,
        builder: (context, state) {
          if (state is GetSearchMoviesLoadingState) {
            return CircularProgressIndicator();
          }

          if (state is GetSearchMoviesFailureState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  title: Text(
                    'ERROR :(\n\n Ocorreu um erro!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                  backgroundColor: Colors.red,
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                        style: ButtonStyle(alignment: Alignment.center),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            );
          }

          if (state is MovieNotFoundFailureState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  title: Text(
                    'ERROR :(\n\n Filme não encontrado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                  backgroundColor: Colors.red,
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                        style: ButtonStyle(alignment: Alignment.center),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            );
          }

          if (state is GetSearchMoviesSucessState) {
            if (state.searchMoviesList.movies.isEmpty) {
              return Container();
            }

            return ListView.builder(
                itemCount: state.searchMoviesList.movies.length,
                itemBuilder: (context, position) {
                  if (state.searchMoviesList.movies[position].title.isEmpty) {
                    return SizedBox();
                  }

                  return Container(
                    color: Color.fromARGB(255, 4, 28, 29),
                    child: Card(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Color.fromARGB(255, 19, 3, 252).withAlpha(30),
                        onTap: () {
                          Modular.to.pushNamed(
                            '/movies/movieDetails/',
                            arguments: [
                              state.searchMoviesList.movies[position].id,
                            ],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500${state.searchMoviesList.movies[position].poster}',
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) {
                                  return Image.network(
                                    'https://static.thenounproject.com/png/3237447-200.png',
                                    width: 150,
                                    height: 200,
                                    color: Colors.white,
                                  );
                                },
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.52,
                                        child: Text(
                                          state.searchMoviesList.movies[position].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      state.searchMoviesList.movies[position].releaseDate.isEmpty
                                          ? SizedBox()
                                          : Text(
                                              state.searchMoviesList.movies[position].releaseDate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      state.searchMoviesList.movies[position].overview.isEmpty
                                          ? SizedBox()
                                          : SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.52,
                                              child: Text(
                                                state.searchMoviesList.movies[position].overview,
                                                maxLines: 6,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                      SizedBox(height: 7),
                                      state.searchMoviesList.movies[position].score.isEmpty
                                          ? SizedBox()
                                          : Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  state.searchMoviesList.movies[position].score,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

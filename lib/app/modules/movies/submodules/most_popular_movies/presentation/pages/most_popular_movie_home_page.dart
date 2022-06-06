import 'package:flix_clean_ark/app/modules/movies/presentation/settings/movie_poster_url.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/get_movies_list/events/get_most_popular_movies_event.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_failure_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/get_movies_list/states/get_movies_list_sucess_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/most_popular_movies/presentation/blocs/get_movies_list/states/most_popular_movies_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../blocs/get_movies_list/most_popular_movies_bloc.dart';

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
      appBar: AppBar(
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
              // showSearch(context: context, delegate: MySearchDelegate());
            }),
            icon: Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.search,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailScreen())));
        },
        child: Icon(
          Icons.favorite,
          size: 30,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Padding(
              //   padding: EdgeInsets.only(bottom: 7),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Color.fromARGB(88, 0, 0, 0),
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //     height: 50,
              //     width: 200,
              //     child: Center(
              //       child: FutureBuilder(
              //         future: FiltroApi().apifunctiondetails(),
              //         builder: ((context, snapshot) {
              //           if (snapshot.connectionState == ConnectionState.done) {
              //             List<ListFiltro> data = snapshot.data as List<ListFiltro>;

              //             return DropdownButton<String>(
              //               icon: Icon(
              //                 Icons.filter_alt,
              //                 color: Colors.white,
              //                 size: 24,
              //               ),
              //               value: dropdonwValue,
              //               onChanged: (String? newValue) {
              //                 setState(() {
              //                   dropdonwValue = newValue!;
              //                   genreId = data.firstWhere((element) => element.name == newValue).id;
              //                 });
              //               },
              //               dropdownColor: Colors.blue,
              //               items: data.map((ListFiltro genero) {
              //                 return DropdownMenuItem(
              //                   value: genero.name,
              //                   child: Text(
              //                     genero.name,
              //                     style: TextStyle(
              //                         fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              //                   ),
              //                 );
              //               }).toList(),
              //             );
              //           }
              //           if (snapshot.connectionState == ConnectionState.waiting) {
              //             return const CircularProgressIndicator();
              //           }
              //           return const SizedBox();
              //         }),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: BlocBuilder<MostPopularMoviesBloc, MostPopularMoviesStates>(
                  bloc: mostPopularMoviesBloc,
                  builder: (context, state) {
                    if (state is GetMoviesListSucessState) {
                      return ListView.builder(
                        itemCount: state.movieList.movies.length,
                        itemBuilder: (context, position) {
                          return Card(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Color.fromARGB(255, 19, 3, 252).withAlpha(30),
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: ((context) => Apifuntion(data[position].id))));
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            state.movieList.movies[position].releaseDate,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
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
                                                    fontWeight: FontWeight.bold),
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
                      );
                    }
                    if (state is GetMoviesListLoadingState) {
                      return Center(child: const CircularProgressIndicator());
                    }

                    if (state is GetMoviesListFailureState) {
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
                              onPressed: () {
                                mostPopularMoviesBloc.add(
                                  GetMostPopularMoviesEvent(),
                                );
                              },
                              child: Text('Tentar novamente'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

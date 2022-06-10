import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/get_movie_details_loading_state.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/presentation/blocs/get_movie_details_bloc/states/movie_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../presentation/settings/movie_poster_url.dart';
import '../blocs/get_movie_details_bloc/events/get_movie_details_event.dart';
import '../blocs/get_movie_details_bloc/get_movie_details_bloc.dart';
import '../blocs/get_movie_details_bloc/states/get_movie_details_sucess_state.dart';

class MovieDetailsPage extends StatefulWidget {
  final int id;

  MovieDetailsPage({required this.id});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final movieDetailsBloc = Modular.get<GetMovieDetailsBloc>();

  @override
  void initState() {
    movieDetailsBloc.add(GetMovieDetailsEvent(MovieDetailsParameters(widget.id)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GetMovieDetailsBloc, MovieDetailsStates>(
          bloc: movieDetailsBloc,
          builder: (context, state) {
            if (state is GetMovieDetailsLoadingState) {
              return Center(child: const CircularProgressIndicator());
            }

            if (state is GetMovieDetailsSucessState) {
              return Scaffold(
                backgroundColor: Color.fromARGB(255, 4, 28, 29),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Title: ${state.movieDetails.title}'),
                          ),
                        );
                      }),
                      icon: Icon(Icons.info),
                    )
                  ],
                ),
                body: state.movieDetails.title.isEmpty
                    ? Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
                              Text(
                                "An error has occurred!!\nTry again later :(",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => GestureDetector(
                                            child: Image.network(
                                              '${MoviesSettings.moviePosterUrl}${state.movieDetails.poster}',
                                              errorBuilder: (context, error, stack) {
                                                return Image.network(
                                                    'https://static.thenounproject.com/png/3237447-200.png',
                                                    color: Colors.white);
                                              },
                                            ),
                                            onTap: () => Navigator.pop(context),
                                          ));
                                },
                                child: Image.network(
                                  '${MoviesSettings.moviePosterUrl}${state.movieDetails.poster}',
                                  width: MediaQuery.of(context).size.width * 0.52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      'https://static.thenounproject.com/png/3237447-200.png',
                                      width: MediaQuery.of(context).size.width * 0.52,
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${state.movieDetails.title}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(3, 3),
                                            blurRadius: 5.0,
                                            color: Color.fromARGB(255, 66, 66, 66),
                                          ),
                                        ],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  state.movieDetails.score == "-1"
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              state.movieDetails.score,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  state.movieDetails.releaseDate.isEmpty
                                      ? SizedBox()
                                      : Text(
                                          'Release Date: ${state.movieDetails.releaseDate}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  state.movieDetails.runtime.isNegative
                                      ? SizedBox()
                                      : Text(
                                          'Duration: ${state.movieDetails.runtime} min',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  state.movieDetails.genres.isEmpty
                                      ? SizedBox()
                                      : Text(
                                          'Genres: ${state.movieDetails.genres.join(', ')}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                  Padding(padding: EdgeInsets.all(12)),
                                  state.movieDetails.overview.isEmpty
                                      ? SizedBox()
                                      : Text(
                                          'Overview: ${state.movieDetails.overview}',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  ((Uri.tryParse(state.movieDetails.site)?.hasAbsolutePath ?? false)
                                      ? TextButton(
                                          onPressed: () async {
                                            await launchUrl(Uri.parse(state.movieDetails.site));
                                          },
                                          child: Text(
                                            'Site: ${state.movieDetails.site}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightBlueAccent),
                                          ),
                                        )
                                      : SizedBox()),
                                  Padding(padding: EdgeInsets.all(3)),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(primary: Colors.green),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Column(
                                              children: [
                                                TextButton.icon(
                                                  icon: Icon(
                                                    Icons.download,
                                                    color: Colors.blue,
                                                    size: 50,
                                                  ),
                                                  onPressed: () {},
                                                  label: Text(''),
                                                ),
                                                Text(
                                                  ':( Sorry. \nNot Vailable for !',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor: Colors.white,
                                            actionsAlignment: MainAxisAlignment.end,
                                            actions: [
                                              TextButton(
                                                style: ButtonStyle(alignment: Alignment.center),
                                                onPressed: () => Navigator.pop(context),
                                                child: Icon(Icons.close, size: 30, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.download,
                                      ),
                                      label: Text(
                                        'Download {1080p}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(primary: Colors.white),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Container(
                                              alignment: Alignment.center,
                                              color: Colors.black,
                                              height: 300,
                                              width: 800,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  TextButton.icon(
                                                    icon: Icon(
                                                      Icons.play_circle,
                                                      color: Colors.white,
                                                      size: 100,
                                                    ),
                                                    onPressed: () {},
                                                    label: Text(''),
                                                  ),
                                                  SizedBox(),
                                                  Text(
                                                    ':( Sorry. \nPlayer not found !',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor: Colors.white,
                                            actionsAlignment: MainAxisAlignment.end,
                                            actions: [
                                              TextButton(
                                                style: ButtonStyle(alignment: Alignment.center),
                                                onPressed: () => Navigator.pop(context),
                                                child: Icon(Icons.close, size: 30, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        color: Colors.blue,
                                      ),
                                      label: Text(
                                        'Pt-BR {720p}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(primary: Colors.white),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Container(
                                              alignment: Alignment.center,
                                              color: Colors.black,
                                              height: 300,
                                              width: 800,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  TextButton.icon(
                                                    icon: Icon(
                                                      Icons.play_circle,
                                                      color: Colors.white,
                                                      size: 100,
                                                    ),
                                                    onPressed: () {},
                                                    label: Text(''),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    ':( Sorry. \nPlayer not Found !',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor: Colors.white,
                                            actionsAlignment: MainAxisAlignment.end,
                                            actions: [
                                              TextButton(
                                                style: ButtonStyle(alignment: Alignment.center),
                                                onPressed: () => Navigator.pop(context),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 30,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        color: Colors.blue,
                                      ),
                                      label: Text(
                                        'En-US {720p}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  Padding(padding: EdgeInsets.all(5)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Image.asset('assets/first_scren-removebg.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

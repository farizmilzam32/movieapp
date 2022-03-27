import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/model/trendingmovie.dart';
import 'package:movieapp/services/apihelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiHelper apiProvider = ApiHelper();
  Future<TrendingMovies>? trendingMovies;

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    trendingMovies = apiProvider.getTrendingMovies();
    super.initState();
  }

  Future<void> refresh() async{
    await apiProvider.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: trendingMovies,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("Has Data: ${snapshot.hasData}");
              return ListView.builder(
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return moviesItem(
                      poster:
                          '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                      originalName:
                          '${snapshot.data.results[index].originalName}',
                      title: '${snapshot.data.results[index].title}',
                      date: '${snapshot.data.results[index].releaseDate}',
                      voteAverage: '${snapshot.data.results[index].voteAverage}',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MovieDetail(
                                  movie: snapshot.data.results[index],
                                )));
                      });
                },
              );
            } else if (snapshot.hasError) {
              print("Has Error: ${snapshot.error}");
              return const Text('Error!!!');
            } else {
              print("Loading...");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget moviesItem(
      {required String poster,
      required String title,
      required String originalName,
      required String date,
      required String voteAverage,
      required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 120,
                child: CachedNetworkImage(
                  imageUrl: poster,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        originalName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(date),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(voteAverage),
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
    );
  }
}

class MovieDetail extends StatelessWidget {
  final Result movie;
  final String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
      ),
      body: Column(
        children: [
          Image.network(imageBaseUrl + movie.posterPath!),
          Text(movie.overview!),
          Text(movie.popularity!.toString()),
        ],
      ),
    );
  }
}

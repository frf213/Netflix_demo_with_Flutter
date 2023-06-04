import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_demo/services/tmdb_api_service.dart';
import 'package:netflix_demo/screens/movie_details_screen.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final apiService = TMDBApiService();
      final movies = await apiService.getMovies();
      setState(() {
        _movies = movies;
      });
    } catch (e) {
      print('Error fetching movies: $e');
      // Handle the error gracefully in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: _movies.isNotEmpty
          ? ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          final title = movie['title'];
          final imageUrl =
              'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    title: movie['title'],
                    imageUrl: imageUrl,
                    description: movie['overview'],
                    releaseDate: movie['release_date'],
                    rating: movie['vote_average'],
                  ),
                ),
              );
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

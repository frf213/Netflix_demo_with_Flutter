import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_demo/services/tmdb_api_service.dart';

class PopularMoviesScreen extends StatefulWidget {
  @override
  _PopularMoviesScreenState createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
  }

  Future<void> _fetchPopularMovies() async {
    try {
      final apiService = TMDBApiService();
      final popularMovies = await apiService.getPopularMovies();
      setState(() {
        _movies = popularMovies;
      });
    } catch (e) {
      print('Error fetching popular movies: $e');
      // Handle the error gracefully in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
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
              // Add navigation logic to movie details screen
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

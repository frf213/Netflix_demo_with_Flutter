import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_demo/services/tmdb_api_service.dart';

class TopRatedMoviesScreen extends StatefulWidget {
  @override
  _TopRatedMoviesScreenState createState() => _TopRatedMoviesScreenState();
}

class _TopRatedMoviesScreenState extends State<TopRatedMoviesScreen> {
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchTopRatedMovies();
  }

  Future<void> _fetchTopRatedMovies() async {
    try {
      final apiService = TMDBApiService();
      final topRatedMovies = await apiService.getTopRatedMovies();
      setState(() {
        _movies = topRatedMovies;
      });
    } catch (e) {
      print('Error fetching top-rated movies: $e');
      // Handle the error gracefully in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: _movies.isNotEmpty
          ? ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          final title = movie['title'];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
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

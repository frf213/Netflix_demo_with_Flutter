import 'package:flutter/material.dart';
import 'package:netflix_demo/services/tmdb_api_service.dart';
import 'package:netflix_demo/screens/movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchMovies(String query) async {
    try {
      final apiService = TMDBApiService();
      final movies = await apiService.searchMovies(query);
      setState(() {
        _searchResults = movies;
      });
    } catch (e) {
      print('Error searching movies: $e');
      // Handle the error gracefully in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies',
          ),
          onChanged: (query) {
            if (query.isNotEmpty) {
              _searchMovies(query);
            } else {
              setState(() {
                _searchResults = [];
              });
            }
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final movie = _searchResults[index];
          final title = movie['title'];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

          return ListTile(
            leading: imageUrl != null
                ? Image.network(
              imageUrl,
              width: 60,
              height: 90,
              fit: BoxFit.cover,
            )
                : SizedBox.shrink(),
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
      ),
    );
  }
}

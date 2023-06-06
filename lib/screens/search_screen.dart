import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_demo/screens/movie_details_screen.dart';
import 'package:netflix_demo/screens/tvseries_details_screen.dart';

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

  Future<void> _searchMoviesAndTVSeries(String query) async {
    final String apiKey = "080184f9aad4105504265a00cf70d578"; // Replace with your TMDB API key
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String moviesUrl = '$baseUrl/search/movie?api_key=$apiKey&query=$query';
    final String tvSeriesUrl = '$baseUrl/search/tv?api_key=$apiKey&query=$query';

    final movieResponse = await http.get(Uri.parse(moviesUrl));
    final tvSeriesResponse = await http.get(Uri.parse(tvSeriesUrl));

    if (movieResponse.statusCode == 200 && tvSeriesResponse.statusCode == 200) {
      final movieData = jsonDecode(movieResponse.body);
      final tvSeriesData = jsonDecode(tvSeriesResponse.body);

      setState(() {
        _searchResults = [...movieData['results'], ...tvSeriesData['results']];
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies or TV series',
          ),
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              _searchMoviesAndTVSeries(query);
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
          final item = _searchResults[index];
          final title = item['title'] ?? item['name'];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${item['poster_path']}';
          final isMovie = item['title'] != null;

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
                  builder: (context) => isMovie
                      ? MovieDetailsScreen(
                    title: title,
                    imageUrl: imageUrl,
                    description: item['overview'],
                    releaseDate: item['release_date'],
                    rating: item['vote_average'],
                  )
                      : TVSeriesDetailsScreen(
                    title: title,
                    imageUrl: imageUrl,
                    description: item['overview'],
                    releaseDate: item['first_air_date'],
                    rating: item['vote_average'],
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

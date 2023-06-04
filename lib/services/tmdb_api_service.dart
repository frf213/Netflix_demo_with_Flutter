import 'dart:convert';

import 'package:http/http.dart' as http;

class TMDBApiService {
  static const String _apiKey = '080184f9aad4105504265a00cf70d578';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> getMovies() async {
    final url = '$_baseUrl/movie/popular?api_key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final movies = jsonData['results'] as List<dynamic>;
        return movies;
      } else {
        throw Exception('Failed to fetch movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }

  Future<dynamic> _get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint?api_key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to retrieve data from TMDB API');
    }
  }

  Future<List<dynamic>> getPopularMovies() async {
    final endpoint = '/movie/popular';
    final result = await _get(endpoint);

    return result['results'];
  }

  Future<List<dynamic>> getTopRatedMovies() async {
    final endpoint = '/movie/top_rated';
    final result = await _get(endpoint);

    return result['results'];
  }

  Future<List<dynamic>> getTrendingMovies() async {
    final endpoint = '/trending/movie/week';
    final result = await _get(endpoint);

    return result['results'];
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final endpoint = '/search/movie?query=$query';
    final result = await _get(endpoint);

    return result['results'];
  }
}

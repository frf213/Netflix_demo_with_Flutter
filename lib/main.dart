import 'package:flutter/material.dart';
import 'package:netflix_demo/screens/home_screen.dart';
import 'package:netflix_demo/screens/movie_screen.dart';
import 'package:netflix_demo/screens/movie_details_screen.dart';
import 'package:netflix_demo/screens/popular_movies_screen.dart';
import 'package:netflix_demo/screens/popular_tvseries_screen.dart';
import 'package:netflix_demo/screens/search_screen.dart';
import 'package:netflix_demo/screens/top_rated_movies_screen.dart';
import 'package:netflix_demo/screens/top_rated_tvseries_screen.dart';
import 'package:netflix_demo/screens/tvseries_details_screen.dart';
import 'package:netflix_demo/screens/user_profile_screen.dart';

void main() {
  runApp(NetflixDemoApp());
}

class NetflixDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/movie': (context) => MovieScreen(),
        '/movie_details': (context) => MovieDetailsScreen(
          title: 'Movie Title',
          imageUrl: 'https://example.com/movie_image.jpg',
          description: 'Movie description goes here.',
          releaseDate: '2023-06-01',
          rating: 8.5,
        ),
        '/tvseries_details': (context) => TVSeriesDetailsScreen(
          title: 'TV Series Title',
          imageUrl: 'https://example.com/tvseries_image.jpg',
          description: 'TV series description goes here.',
          releaseDate: '2023-06-01',
          rating: 9.0,
        ),
        '/popular_movies': (context) => PopularMoviesScreen(),
        '/top_rated_movies': (context) => TopRatedMoviesScreen(),
        '/popular_tvseries': (context) => PopularTVSeriesScreen(),
        '/top_rated_tvseries': (context) => TopRatedTVSeriesScreen(),
        '/search': (context) => SearchScreen(),
        '/user_profile': (context) => UserProfileScreen(
          username: 'FrF',
          email: 'farhanfuad@iut-dhaka.edu',
          profileImage: 'https://example.com/profile.jpg',
        ),
      },
    );
  }
}

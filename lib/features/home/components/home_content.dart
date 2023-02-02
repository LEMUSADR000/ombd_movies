import 'package:flutter/material.dart';
import 'package:ombd_movies/features/home/components/movie_search_field.dart';
import 'package:ombd_movies/features/home/components/search_results.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MovieSearchField(),
          ),
          Flexible(child: SearchResults()),
        ],
      ),
    );
  }
}

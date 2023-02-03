import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';
import 'package:ombd_movies/features/movie_loader/movie_result_card.dart';
import 'package:ombd_movies/services/api/repositories/models/search_results.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
    final List<Search> searchResults =
        (bloc.state as ViewingSearchResults).searchResults;

    if (searchResults.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 50),
        child: const Text(
          "No results found",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Search Results",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: searchResults.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (_, i) {
                final Search search = searchResults[i];

                return BlocProvider(
                  create: (context) => getIt<MovieLoaderBloc>()
                    ..add(MovieLoaderEvent.load(search.imdbID)),
                  child: MovieResultCard(
                    id: search.imdbID,
                    imageUrl: search.poster,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

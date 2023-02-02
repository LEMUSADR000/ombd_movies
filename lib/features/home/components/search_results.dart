import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (_, state) {
        if (state is SearchFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Search failed. Please try again later."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      buildWhen: (_, curr) => curr is! SearchFailed,
      builder: (_, state) {
        final Widget child;
        if (state is Searching) {
          child = const Center(child: CircularProgressIndicator());
        } else if (state is ViewingSearchResults) {
          child = ListView.builder(
            itemCount: state.searchResults.length,
            itemBuilder: (_, i) {
              return ListTile(title: Text(state.searchResults[i]));
            },
          );
        } else {
          child = ListView.builder(
            itemCount: state.recentlyViewed.length,
            itemBuilder: (_, i) {
              return ListTile(title: Text(state.recentlyViewed[i]));
            },
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: child,
        );
      },
    );
  }
}

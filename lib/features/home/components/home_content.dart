import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/home/components/idle_content.dart';
import 'package:ombd_movies/features/home/components/movie_search_field.dart';
import 'package:ombd_movies/features/home/components/recently_viewed.dart';
import 'package:ombd_movies/features/home/components/search_results.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is SearchFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Search failed. Please try again later."),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: MovieSearchField(),
            ),
            Flexible(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (_, curr) => curr is! SearchFailed,
                builder: (_, state) {
                  final Widget child;
                  if (state is Searching) {
                    child = const Center(child: CircularProgressIndicator());
                  } else if (state is ViewingSearchResults) {
                    child = const SearchResults();
                  } else {
                    child = Stack(
                      children: [
                        const IdleContent(),
                        if (state.hasKeyboardFocus) const RecentlyViewed()
                      ],
                    );
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

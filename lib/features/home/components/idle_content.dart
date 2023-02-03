import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';
import 'package:ombd_movies/features/movie_loader/movie_result_card.dart';

class IdleContent extends StatelessWidget {
  const IdleContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Favorites",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Flexible(
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (prev, curr) => prev.favorites != curr.favorites,
              builder: (context, state) {
                final List<String> favorites =
                    state.favorites.toList(growable: false);

                print('rebuilding with $favorites');

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: favorites.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (_, i) {
                    return BlocProvider(
                      create: (context) => getIt<MovieLoaderBloc>()
                        ..add(MovieLoaderEvent.load(favorites[i])),
                      child: MovieResultCard(
                        id: favorites[i],
                        showMetadata: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

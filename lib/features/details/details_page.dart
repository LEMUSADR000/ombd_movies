import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/common/text_item_row.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage._({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MovieLoaderBloc;

    return BlocProvider.value(
      value: args,
      child: const DetailsPage._(),
    );
  }

  static const String routeName = 'details_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<MovieLoaderBloc, MovieLoaderState>(
            listener: (_, state) {
              if (state is Failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Failed to load movie. Please try again later."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state.search == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final search = state.search!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 420,
                        width: 300,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: search.poster ?? '_bad_url',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (_, state) {
                        return IconButton(
                          icon: Icon(state.favorites.contains(search.imdbID)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            context
                                .read<HomeBloc>()
                                .add(HomeEvent.favorite(id: search.imdbID));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextItemRow(
                      left: "Title",
                      right: search.title ?? 'N/A',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextItemRow(
                      left: "Year",
                      right: search.year ?? 'N/A',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextItemRow(
                      left: "Runtime",
                      right: search.runtime ?? 'N/A',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextItemRow(
                      left: "Actors",
                      right: search.actors ?? 'N/A',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextItemRow(
                      left: "Plot",
                      right: search.plot ?? 'N/A',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Ratings",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final rating in state.search?.ratings ?? [])
                                Flexible(
                                  child: Text(
                                    rating.source != null &&
                                            rating.value != null
                                        ? '${rating.source!}: ${rating.value!}'
                                        : '     ',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

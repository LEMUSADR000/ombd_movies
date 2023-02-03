import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/details/details_page.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';

class MovieResultCard extends StatelessWidget {
  const MovieResultCard({
    required this.id,
    this.showMetadata = false,
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String id;
  final bool showMetadata;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieLoaderBloc, MovieLoaderState>(
      listener: (context, state) {
        if (state is Failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to load movie(s). Please try again later."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300, minHeight: 300),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.withAlpha(0x29)),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: context.read<MovieLoaderBloc>(),
                );
              },
              child: SizedBox(
                width: 200,
                child: BlocBuilder<MovieLoaderBloc, MovieLoaderState>(
                  builder: (context, state) {
                    final String url = state.search?.poster ?? imageUrl ?? '';

                    /// ASSUMPTION: We want to cache any image requests we make
                    /// since re-requesting images can be an expensive problem
                    /// to have & this really helps make scrolling as smooth
                    /// as possible.
                    return CachedNetworkImage(
                      fit: BoxFit.scaleDown,
                      imageUrl: url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (showMetadata)
            BlocBuilder<MovieLoaderBloc, MovieLoaderState>(
              builder: (context, state) {
                return Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: state.search?.title == null ? 0 : null,
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.search?.title ?? 'N/A',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          if (showMetadata)
            BlocBuilder<MovieLoaderBloc, MovieLoaderState>(
              builder: (context, state) {
                return Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: state.search?.year == null ? 0 : null,
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.search?.year ?? 'N/A',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          if (showMetadata)
            BlocBuilder<MovieLoaderBloc, MovieLoaderState>(
              builder: (context, state) {
                return Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: state.search?.runtime == null ? 0 : null,
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.search?.runtime ?? 'N/A',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

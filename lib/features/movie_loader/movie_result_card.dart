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
    return Column(
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                height: state is Loading ? 0 : null,
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
                height: state is Loading ? 0 : null,
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
                height: state is Loading ? 0 : null,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  state.search?.runtime ?? 'N/A',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
      ],
    );
  }
}

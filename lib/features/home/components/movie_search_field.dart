import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';

class MovieSearchField extends StatefulWidget {
  const MovieSearchField({Key? key}) : super(key: key);

  @override
  State<MovieSearchField> createState() => _MovieSearchFieldState();
}

class _MovieSearchFieldState extends State<MovieSearchField> {
  bool keyboardHasFocus = false;

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          keyboardHasFocus = hasFocus;
        });
      },
      child: TextFormField(
        controller: bloc.editingController,
        decoration: InputDecoration(
          suffixIcon: BlocBuilder<HomeBloc, HomeState>(
            builder: (_, state) {
              final bool viewingResults = state is ViewingSearchResults;

              return IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    viewingResults ? Icons.highlight_remove : Icons.search,
                    color: keyboardHasFocus ? Colors.blue : null,
                  ),
                ),
                onPressed: viewingResults
                    ? () {
                        bloc.add(const HomeEvent.exitSearch());
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    : null,
              );
            },
          ),
          border: const OutlineInputBorder(),
        ),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (_) => bloc.add(const HomeEvent.search()),
      ),
    );
  }
}

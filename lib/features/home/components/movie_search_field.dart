import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';

class MovieSearchField extends StatelessWidget {
  const MovieSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();

    return Focus(
      onFocusChange: (hasFocus) => bloc.add(HomeEvent.setFocus(hasFocus)),
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
                    color: state.hasKeyboardFocus ? Colors.blue : null,
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
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (_) => bloc.add(const HomeEvent.tapSearch()),
      ),
    );
  }
}

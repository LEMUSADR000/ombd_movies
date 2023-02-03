import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = context.read<HomeBloc>();
    final List<String> recentlySearched = bloc.state.recentlySearched;

    return Container(
      margin: const EdgeInsets.only(left: 0, top: 0, right: 0),
      color: Color.alphaBlend(Colors.blue.withOpacity(0.1), Colors.white),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) => TextButton(
          child: Text(recentlySearched[i]),
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(HomeEvent.tapRecentSearch(term: recentlySearched[i]));
          },
        ),
        itemCount: recentlySearched.length,
        shrinkWrap: true,
      ),
    );
  }
}

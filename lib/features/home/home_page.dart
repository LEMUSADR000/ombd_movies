import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/home/components/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key? key}) : super(key: key);

  factory HomePage.builder(BuildContext context) {
    return const HomePage._();
  }

  static String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('OMBD Movies')),
        body: const HomeContent(),
      ),
    );
  }
}

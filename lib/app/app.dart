import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/app/routes.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';

class OMBDMoviesApp extends StatelessWidget {
  const OMBDMoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: MaterialApp(
        title: 'OMBD Movie Viewer',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: Navigation.routes,
        initialRoute: Navigation.initialRoute,
      ),
    );
  }
}

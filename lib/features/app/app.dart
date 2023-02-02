import 'package:flutter/material.dart';
import 'package:ombd_movies/features/app/routes.dart';

class OMBDMoviesApp extends StatelessWidget {
  const OMBDMoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMBD Movie Viewer',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: Navigation.routes,
      initialRoute: Navigation.initialRoute,
    );
  }
}

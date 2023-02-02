import 'package:flutter/material.dart';
import 'package:ombd_movies/features/details/details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key? key}) : super(key: key);

  factory HomePage.builder(BuildContext context) {
    return const HomePage._();
  }

  static String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OMBD Movies'),
      ),
      body: SafeArea(
        child: TextButton(
          child: Text('Navigate'),
          onPressed: () {
            Navigator.pushNamed(context, DetailsPage.routeName);
          },
        ),
      ),
    );
  }
}

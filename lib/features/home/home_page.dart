import 'package:flutter/material.dart';
import 'package:ombd_movies/features/home/components/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key? key}) : super(key: key);

  factory HomePage.builder(BuildContext context) {
    return const HomePage._();
  }

  static String routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('OMBD Movies')),
      body: const HomeContent(),
    );
  }
}

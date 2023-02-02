import 'package:flutter/material.dart';
import 'package:ombd_movies/features/details/details_page.dart';
import 'package:ombd_movies/features/home/home_page.dart';

abstract class Navigation {
  static String initialRoute = HomePage.routeName;

  static Map<String, WidgetBuilder> routes = {
    HomePage.routeName: HomePage.builder,
    DetailsPage.routeName: DetailsPage.builder,
  };
}

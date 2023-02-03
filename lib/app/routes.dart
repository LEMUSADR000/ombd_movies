import 'package:flutter/material.dart';
import 'package:ombd_movies/features/details/details_page.dart';
import 'package:ombd_movies/features/home/home_page.dart';

abstract class Navigation {
  /// ASSUMPTION: Current initial route is home but in a larger application with
  /// authentication this would actually be some form of login or page for
  /// navigating through sign-on-independant views
  static String initialRoute = HomePage.routeName;

  /// ASSUMPTION: We will need more routes, so we will create an object
  /// that allows for easy scaling of this information
  static Map<String, WidgetBuilder> routes = {
    HomePage.routeName: HomePage.builder,
    DetailsPage.routeName: DetailsPage.builder,
  };
}

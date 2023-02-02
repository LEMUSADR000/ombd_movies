import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage._({Key? key}) : super(key: key);

  factory DetailsPage.builder(BuildContext context) {
    return const DetailsPage._();
  }

  static const String routeName = 'details_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}

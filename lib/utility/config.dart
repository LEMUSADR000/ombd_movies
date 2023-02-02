import 'package:flutter/material.dart';

@immutable
class Config {
  const Config(this.token);

  final String token;

  String get ombdBaseUrl => 'http://www.omdbapi.com/';
}

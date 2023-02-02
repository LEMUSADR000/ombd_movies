import 'package:ombd_movies/entry_point.dart';
import 'package:ombd_movies/utility/config.dart';

Future<void> main() async {
  const String token = String.fromEnvironment('token', defaultValue: '');

  if (token != '') {
    await EntryPoint.runWithConfig(const Config(token));
  } else {
    throw Exception(
      "Unhandled build environment: '$token' - Did we forget to add "
      'dart-define flag? This may be done by appending build flag'
      '`--dart-define=env=<environment>` to `flutter run` where <environment>'
      ' is the flavor we intend to build',
    );
  }
}

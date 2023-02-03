import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/app/app.dart';
import 'package:ombd_movies/app/bloc_observer.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/utility/config.dart';

abstract class EntryPoint {
  static Future<void> runWithConfig(Config config) async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = AppBlocObserver();

    runZonedGuarded(
      () async {
        /// ASSUMPTION: In a real application we'd likely have a mix of
        /// build flavors targeting dev, staging, and production. Our config
        /// may be mutated to have a flag for this and then this will be used
        /// within our dependency injection/service locator to initialize our
        /// dependencies with appropriate flags.
        getIt.init(config: config);

        // Placing 10 seconds wait on initializing dependencies - this particular
        // application will never get close to using up all of this time so if
        // it fails to load, it's because of an error
        await getIt.allReady(timeout: const Duration(seconds: 10));

        runApp(const OMBDMoviesApp());
      },
      (error, stackTrace) async {
        if (kDebugMode) {
          print('runZonedGuarded caught error\n\n$error\n\n$stackTrace');
        }
      },
    );
  }
}

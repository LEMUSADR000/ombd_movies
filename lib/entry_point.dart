import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd_movies/di/di.dart';
import 'package:ombd_movies/features/app/app.dart';
import 'package:ombd_movies/features/app/bloc_observer.dart';
import 'package:ombd_movies/utility/config.dart';

abstract class EntryPoint {
  static Future<void> runWithConfig(Config config) async {
    Bloc.observer = AppBlocObserver();

    runZonedGuarded(
      () async {
        getIt.init(config: config);
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

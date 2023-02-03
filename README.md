# ombd_movies
Movie viewer application meant to interact with https://www.omdbapi.com/

### Startup

You will need to create a token at https://www.omdbapi.com/ if you don't already have one.

```
flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs

flutter run --dart-define=token=<token>
```

### Notes
If I had more time...
* Pulled search functionality into its own dropdown modal for easier state management of 'actively searching' state
* Created a paginated search result view, right now we only display the first page of results but the backend appears to support paged requests
* Create a more fleshed out set of unit tests including widgets
* Sorting functionality for favorites
* Ensure that application works & looks good on different form factors (I used an iPhone 14 Pro for emulation)
* General app logging

### Project Structure
```
mobile_app_architecture
└── lib
    ├── entry_point.dart                    Abstract entry point, wraps the app with the passed config
    ├── main_get_it.dart                    Get it based repositories entry point
    ├── app
    │   ├── application.dart                Top-level app widget (`MaterialApp`)
    │   ├── bloc_observer.dart              An interface for observing the behavior of Bloc instances (very useful for logging)
    │   └── routes.dart                     Map of named routes used in the app
    ├── di
    │   └── di.dart                         Service locator
    ├── features
    │   ├── ...                             Application screens(features)
    │   ├── ...                             Each feature can have such directories as `bloc`,
    │   ├── ...                             'components' (widgets related to this screen), 'models', 'utils'
    ├── services
    │   ├── api
    │   │   ├── chopper
    │   │   │   └── ...                     Chopper services for each api endpoint
    │   │   ├── models
    │   │   │   └── ...                     API response models
    │   │   ├── repositories                
    │   │   │   └── ...                     Domain layer data repositories
    │   ├── local
    │   │   ├── storage.dart                Shared preferences wrapper
    │   │   └── storage_migration
    │   │       └── ...                     Classes related to shared preferences migration
    └── utils
        └── config                          Config model which can be modified in any way to suit the needs of the application
└── test
    └── unit testing files and directories
```

### Known Issues

If you encounter the below issue, it seems to stem from [this](https://github.com/Baseflow/flutter_cached_network_image) package leaking exceptions. If I were
to use this in a production application I would likely attempt to use the forked version found
https://github.com/Baseflow/flutter_cached_network_image/pull/777 where we can provide our
own error listener in order to handle this more gracefully. I thought about foregoing usage of this
Widget but the utility it provided was too great.

```
======== Exception caught by image resource service ================================================
The following ArgumentError was thrown resolving an image codec:
Invalid argument(s): No host specified in URI

When the exception was thrown, this was the stack: 
#0      _HttpClient._openUrl (dart:_http/http_impl.dart:2733:9)
#1      _HttpClient.openUrl (dart:_http/http_impl.dart:2604:7)
#2      IOClient.send (package:http/src/io_client.dart:57:38)
#3      HttpFileService.get (package:flutter_cache_manager/src/web/file_service.dart:35:44)
#4      WebHelper._download (package:flutter_cache_manager/src/web/web_helper.dart:121:24)
#5      WebHelper._updateFile (package:flutter_cache_manager/src/web/web_helper.dart:103:28)
<asynchronous suspension>
#6      WebHelper._downloadOrAddToQueue (package:flutter_cache_manager/src/web/web_helper.dart:71:7)
<asynchronous suspension>
Image provider: CachedNetworkImageProvider("", scale: 1.0) 
 Image key: CachedNetworkImageProvider("", scale: 1.0): CachedNetworkImageProvider("", scale: 1.0)
====================================================================================================
```

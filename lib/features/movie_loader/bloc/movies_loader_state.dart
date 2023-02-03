part of 'movies_loader_bloc.dart';

@freezed
class MovieLoaderState with _$MovieLoaderState {
  const factory MovieLoaderState.loading({SearchResponse? search}) = Loading;
  const factory MovieLoaderState.loaded({SearchResponse? search}) = Loaded;
  const factory MovieLoaderState.failed({SearchResponse? search}) = Failed;
}

part of 'movies_loader_bloc.dart';

@freezed
class MovieLoaderEvent with _$MovieLoaderEvent {
  const factory MovieLoaderEvent.load(String id) = Load;
}

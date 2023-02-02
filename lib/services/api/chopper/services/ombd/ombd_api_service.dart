import 'package:chopper/chopper.dart';

abstract class OmbdApiService {
  Future<Response> fetchMovies();
  Future<Response> search();
}

import 'package:chopper/chopper.dart';

abstract class OmbdApiService {
  Future<Response> search({
    String? exactId,
    String? exactIshTitle,
    String? term,
  });
}

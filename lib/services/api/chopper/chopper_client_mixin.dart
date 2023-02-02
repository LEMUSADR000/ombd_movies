import 'package:chopper/chopper.dart';

mixin ChopperClientMixin {
  ServiceType getService<ServiceType extends ChopperService>();
}

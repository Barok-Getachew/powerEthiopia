import 'package:ethiosolar_app/app/modules/addressScreen/controller/address_controller.dart';
import 'package:get/get.dart';

class AddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
  }
}

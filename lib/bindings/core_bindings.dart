import 'package:get/get.dart';
import 'package:smart_fridge/commons/widgets/network_manager.dart';

class CoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  saveCredentials({
    required String id,
    required String username,
    required String password,
    required String name,
    required bool popular,
    required String image,
    required String address,
  }) {
    storage.write("id", id);
    storage.write("username", username);
    storage.write("password", password);
    storage.write("name", name);
    storage.write("popular", popular);
    storage.write("image", image);
    storage.write("address", address);
  }

  removeStorageCredentials() {
    storage.remove("id");
    storage.remove("username");
    storage.remove("password");
    storage.remove("name");
    storage.remove("popular");
    storage.remove("image");
    storage.remove("address");
  }

  saveRoute({required String screen}) {
    storage.write("screen", screen);
  }

  removeRoute() {
    storage.remove("screen");
  }
}

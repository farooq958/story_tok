import 'package:get/get.dart';
import '../controllers/main_content_controller.dart';

void initializations() {
  Get.put(MainContentController(), permanent: true);
}

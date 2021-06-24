import 'package:get/get.dart';

class CountController extends GetxController {
  final count = 1.obs;
  final price = 50.obs;

  increase() =>  count.value++;
  decrease() => (count.value > 1) ? count.value-- : count.value;

  int get total => count.value * price.value;

}
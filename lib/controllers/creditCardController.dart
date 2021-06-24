import 'package:get/get.dart';
import 'package:strong_delivery/models/CreditCard.dart';

class CreditCardController extends GetxController {
  final creditCard = CreditCard(
          cardHolderName: '',
          cardNumber: '',
          expiryDate: "",
          cvvCode: "",
          isCvvFocused: false)
      .obs;
}

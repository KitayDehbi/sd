import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:strong_delivery/controllers/cartController.dart';
import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/screens/FoodPreparing.dart';
class PaymentCheckout extends StatefulWidget {
  String adresse;
  LatLng p;
  int id;
  PaymentCheckout({this.adresse, this.p, this.id});
  @override
  _PaymentCheckoutState createState() => _PaymentCheckoutState();
}

class _PaymentCheckoutState extends State<PaymentCheckout> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                height: 200,
                width: MediaQuery.of(context).size.width,
                animationDuration: Duration(milliseconds: 1000)),
            OutlineButton(
              child: Text(
                "Poursuivre le payment",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: ()async {
                var id = await CommandeController().sendCommande(widget.adresse , widget.p);
                    CartController().deleteAllProduct();
                    Get.to(FoodPreparing(id: id,));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: CreditCardForm(
                onCreditCardModelChange: onModelChange,
              ),
            ))
          ],
        ),
      ),
    );
  }

  void onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }
}

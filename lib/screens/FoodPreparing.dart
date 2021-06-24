import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/screens/FoodDelivery.dart';

class FoodPreparing extends StatelessWidget {
  final int id;
  const FoodPreparing({this.id});
  getCommandeState() {
    const oneMin = const Duration(minutes: 2);
    new Timer.periodic(oneMin, (Timer t) async {
      var status = await CommandeController().getStatefromId(id);
      if (status == 'en cours') {
        Get.to(FoodDelivery(id: id));
        t.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getCommandeState();
    return Scaffold(
      backgroundColor: Color(0xFFE94E1A),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/FoodPreparing1.png',
              width: MediaQuery.of(context).size.width,
              height: 170,
              fit: BoxFit.cover,
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Text(
                  'Votre commande est en cours de préparation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFE94E1A),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/images/FoodPreparing2.png',
              width: MediaQuery.of(context).size.width,
              height: 140,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}

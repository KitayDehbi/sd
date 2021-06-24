import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/screens/home_screen.dart';

class Services extends StatelessWidget {
  const Services({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Image.asset(
                'assets/images/Layer3.png',
                width: 100,
                height: 150,
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 9),
              child: Text(
                'Livraison rapide',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Notre rapidité est notre fierté. Commandez ou envoyez ce que vous voulez dans votre ville et on s\'occupe de le livrer en quelques minutes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image.asset(
                'assets/images/Layer4.png',
                width: 100,
                height: 150,
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 9),
              child: Text(
                'Les meilleurs restaurants \nde votre ville',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Notre rapidité est notre fierté. Commandez ou envoyez ce que vous voulez dans votre ville et on s\'occupe de le livrer en quelques minutes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Get.to(Dashboard());
                },
                child: Text(
                  'Aller à la page d\'accueil',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

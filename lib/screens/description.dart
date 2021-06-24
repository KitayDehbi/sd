import 'package:get/get.dart';
import 'package:strong_delivery/screens/services.dart';

import '../widgets/page_view_widget.dart';
import '../widgets/restau_icon_widget.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(15, 3),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFE94E1A),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment(0.6, -0.7),
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
                    child: Text(
                      'France: meilleurs restaurants de votre region',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF0F0E0E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.4, -0.25),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
                            child: RestauIconWidget(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: RestauIconWidget(),
                          ),
                          RestauIconWidget()
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 15, 50, 0),
                  child: Text(
                    'Faites livrer rapidement tout vos repas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Image.asset(
                    'assets/images/Layer2.png',
                    width: 100,
                    height: 150,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 9),
                  child: Text(
                    'Vos restaurant préféré',
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
                  'McDonalds - Burger King - Tacos de Lyon....',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 200,
                  child: Align(
                    alignment: Alignment(0, 0),
                    child: PageviewWidget(),
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
                      Get.to(Services());
                    },
                    child: Text(
                      'Découvrire nos Services',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.deepOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/screens/Cart.dart';
import 'package:strong_delivery/screens/home_screen.dart';
import 'package:strong_delivery/screens/auth/client/profile.dart';

class BottomMenu extends StatefulWidget {
  int item;
  BottomMenu(this.item);
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  // final int it;
  // _BottomMenuState(int i){
  //   this.it = i;
  // }
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      this.widget.item = index;
    });
    switch (index) {
      case 0:
        Get.to(Dashboard());
        break;
      case 1:
        //the cart widget;
        Get.to(Cart());
        break;
      case 2:
        //the profile widget;
        Get.to(ProfileClient());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Acceuil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          label: 'Commandes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: this.widget.item,
      selectedItemColor: Colors.deepOrange,
      onTap: _onItemTapped,
    );
  }
}

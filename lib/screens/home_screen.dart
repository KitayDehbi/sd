import 'package:flutter/material.dart';
import 'package:strong_delivery/widgets/BottomMenu.dart';
import 'package:strong_delivery/widgets/list_item_by_category.dart';
import 'package:strong_delivery/widgets/restaurant_selector.dart';



class Dashboard extends StatefulWidget {

  const Dashboard({ Key key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {

  void refresh() {
    setState(() {
      // plats = plattController.getAllPlatOfRestaurant(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            RestaurantSelector(notify: refresh,),
            ListItemsByCategory(),
          ],
        ),
        bottomNavigationBar: BottomMenu(0)
    );
  }
}


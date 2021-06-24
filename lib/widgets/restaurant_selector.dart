import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/restaurantController.dart';

class RestaurantSelector extends StatefulWidget {
  @override
  final Function() notify;
  RestaurantSelector({Key key, @required this.notify}) : super(key: key);
  _RestaurantSelectorState createState() => _RestaurantSelectorState();
}

class _RestaurantSelectorState extends State<RestaurantSelector> {
  //Future list;
  final RestaurantController controller = RestaurantController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller.getAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: controller.getAllRestaurant(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.deepOrange,
            ),
          );
        } else {
          return Container(
            height: 150.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                        await prefs.setInt('res_id', snapshot.data[index].getId());
                        print(snapshot.data[index].getId());
                        widget.notify();
                    },
                    // onTap: (){
                    //   int i = snapshot.data[index].getId();
                    //   setState(() {
                    //     refreshPlat(i);
                    //   });
                    // },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200.0),
                            //child: ,
                            child: Image.network(
                              "${Server.imageUrl + snapshot.data[index].getImage()}",
                              fit: BoxFit.fill,
                              width: 90,
                              height: 90,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                    backgroundColor: Colors.deepOrange,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                              decoration: new BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                    bottomLeft: const Radius.circular(40.0),
                                    bottomRight: const Radius.circular(40.0),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 2, bottom: 2),
                                child: Text(
                                  "${snapshot.data[index].getNom()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15
                                      // backroundColor: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}

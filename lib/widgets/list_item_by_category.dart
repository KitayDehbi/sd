
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/platController.dart';
import 'package:strong_delivery/screens/item_detail_screen.dart';

class ListItemsByCategory extends StatefulWidget {
  @override
  _ListItemsByCategoryState createState() => _ListItemsByCategoryState();
}

class _ListItemsByCategoryState extends State<ListItemsByCategory> {
  final PlatController plattController = PlatController();
  Future<Map<String, dynamic>> plats;
  int resId;

  int i;
  @override
  void initState() {
    // TODO: implement initState
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // resId = await prefs.getInt('res_id');
    super.initState();
    // plattController.getAllPlat();
    // plattController.getAllPlatOfRestaurant(3);
  }

  //
  void refresh() {
    setState(() {
      // plats = plattController.getAllPlatOfRestaurant(i);
    });
  }

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    resId = await prefs.getInt('res_id');
    if (resId == 0)
      plats = plattController.getAllPlat();
    else
      plats = plattController.getAllPlatOfRestaurant(resId);
    return plats;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.deepOrange,
                ),
              );
            } else
              return Container(
                // color: Colors.orangeAccent,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.keys.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
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
                                      left: 15.0,
                                      right: 15.0,
                                      top: 2,
                                      bottom: 2),
                                  child: Text(
                                    '${snapshot.data.keys.toList()[index]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                        // backroundColor: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        // Text("test"),
                        Container(
                          height: 270.0,
                          //rwidth: 120,
                          child: ListView.builder(
                            shrinkWrap: false,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot
                                .data[snapshot.data.keys.toList()[index]]
                                .length,
                            itemBuilder: (context, index2) {
                              return GestureDetector(
                                onTap: () {
                                  // Get.put(
                                  //     snapshot.data[snapshot.data.keys
                                  //         .toList()[index]][index2],
                                  //     tag: "id");

                                  Get.to(ItemDetail(
                                    id: snapshot.data[snapshot.data.keys
                                        .toList()[index]][index2]['id'],
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      //height: double.infinity,
                                      //width: 220,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Stack(
                                            //fit: StackFit.loose,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.network(
                                                  '${Server.imageUrl + snapshot.data[snapshot.data.keys.toList()[index]][index2]['image']}',
                                                  //products[index].image,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 70,
                                                              top: 90),
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Colors.deepOrange,
                                                          backgroundColor:
                                                              Colors.deepOrange,
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes
                                                              : null,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  fit: BoxFit.fill,
                                                  height: 240,
                                                  width: 180,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 150),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          0.0),
                                                  child: Container(
                                                      height: 90,
                                                      width: 180,
                                                      //padding: EdgeInsets.only(top: 180),
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: <Color>[
                                                            Colors.deepOrange
                                                                .withAlpha(0),
                                                            Colors.deepOrange
                                                                .withAlpha(10),
                                                            Colors.deepOrange
                                                                .withAlpha(170),
                                                            Colors.deepOrange
                                                                .withAlpha(220)
                                                          ],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Text(
                                                              '${snapshot.data[snapshot.data.keys.toList()[index]][index2]['nom']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )),
                                                      )),
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: 0.0,
                        // ),
                      ],
                    );
                  },
                ),
              );
          }),
    );
  }
}

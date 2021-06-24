import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/models/CartProduct.dart';
import 'package:strong_delivery/models/MapsUtils.dart';
import 'package:strong_delivery/screens/home_screen.dart';

class CommandeDelivery extends StatefulWidget {
  int commandeId;
  CommandeDelivery({this.commandeId});

  @override
  _CommandeDeliveryState createState() => _CommandeDeliveryState();
}

class _CommandeDeliveryState extends State<CommandeDelivery> {
  List<CartProduct> plats;
  double totalPrice;
  CommandeController commandeController;
  List infos;
  var commandeInfo;

  @override
  void initState() {
    super.initState();
    commandeController = CommandeController();
    getInfos();
  }

  getInfos() async {
    infos = await commandeController.getCommande(widget.commandeId);
    plats = infos[0];
    commandeInfo = infos[1];
    print('commandeInfo');
    print(commandeInfo);
    return plats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FutureBuilder(
        future: getInfos(),
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Totale  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        //Text("Client  : "),
                        Text(
                          commandeInfo["total_price"].toString() + " €",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Réstaurant : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        //Text("Réstaurant : "),
                        Text(
                          commandeInfo["restaurant_name"]
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Client  : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        //Text("Client  : "),
                        Text(
                          commandeInfo["client_name"].toString().toUpperCase(),
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                              ),
                              onPressed: () async {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.best);
                                MapUtils.openMap(
                                    position.latitude,
                                    position.longitude,
                                    double.parse(commandeInfo["client_lat"]),
                                    double.parse(commandeInfo["client_long"]));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(
                                    "client",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                              ),
                              onPressed: () async {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.best);
                                MapUtils.openMap(
                                    position.latitude,
                                    position.longitude,
                                    commandeInfo["restaurant_lat"],
                                    commandeInfo["restaurant_long"]);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  Text(
                                    "Réstaurant",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        //Text(commandeInfo["client_name"]),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      onPressed: () async {
                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.best);
                        await commandeController.Livred(commandeInfo["id"],
                            position.latitude, position.longitude);
                        Get.to(Dashboard());
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            Text(
                              "Livrée",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(),
              height: 260,
            );
          }
        },
      ),
      body: Container(
          child: FutureBuilder(
              future: getInfos(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ListView.builder(
                          itemCount: plats.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 14.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                Server.imageUrl +
                                                    plats[index].image),
                                            fit: BoxFit.cover)),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Text(
                                              '${plats[index].name}',
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w900,
                                                fontStyle: FontStyle.italic,
                                              ),
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 5.0,
                                        // ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            // color: Colors.red,
                                            width: 100.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${plats[index].quantity}",
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Text(
                                              "${plats[index].quantity * plats[index].price} €",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.deepOrange),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                }
              })),
    );
  }
}

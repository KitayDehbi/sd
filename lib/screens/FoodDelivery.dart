import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:strong_delivery/controllers/LivreureController.dart';
import 'package:strong_delivery/controllers/RouteController.dart';
import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/models/DeliveryRoute.dart';
import 'dart:async';

import 'package:strong_delivery/screens/home_screen.dart';


class FoodDelivery extends StatefulWidget {
  int id;
  FoodDelivery({this.id});

  @override
  _FoodDeliveryState createState() => _FoodDeliveryState();
}

class _FoodDeliveryState extends State<FoodDelivery> {
  GoogleMapController mapController;
  RouteController routeController;

  List<LatLng> polyPoints = [];
  Set<Polyline> polyLines = {};
  Set<Marker> markers = {};
  var data;

  // Dummy Start and Destination Points
  double startLat = 0;
  double startLng = 0;
  double endLat = 33.8972656;
  double endLng = -5.5479008;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setMarkers();
  }

  getLivPos(int id) async {
    const oneMin = const Duration(minutes: 2);
    new Timer.periodic(oneMin, (Timer t) async {
     
      var p = await LivreureController().getLivreur(id);
      setState(() {
        startLat = p[0];
        startLng = p[1];
        setMarkers();
        polyLines = {};
        getRoute();
        mapController.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(endLat, endLng),
            zoom: 12,
          ),
        ));
        //setPolyLines();
      });
    });
    return 1;
  }

  @override
  void initState() {
    super.initState();
    init();
    routeController = RouteController();
    //getRoute();
    getComState();
  }

  init() async {
    var com = await getCommande();
    setState(() {
      endLat = double.parse(com["latitude"]);
      endLng = double.parse(com["longitude"]);
      setMarkers();
    });
    getLivPos(com["delivery_id"]);
  }

  getCommande() async {
    return CommandeController().commandeGet(widget.id);
  }
  getComState() async {
    
    const oneMin = const Duration(minutes: 2);
    new Timer.periodic(oneMin, (Timer t) async {
      var com = await getCommande();
      if(com["statut"] == "livré") {
        Get.to(Dashboard());
      }
    });
    return 1;
  }
  setMarkers() {
    markers ={};
    markers.add(
      Marker(
        markerId: MarkerId("Home"),
        position: LatLng(startLat, startLng),
        infoWindow: InfoWindow(
          title: "Home",
          snippet: "Home Sweet Home",
        ),
      ),
    );

    markers.add(Marker(
      markerId: MarkerId("Destination"),
      position: LatLng(endLat, endLng),
      infoWindow: InfoWindow(
        title: "Masjid",
        snippet: "5 star ratted place",
      ),
    ));
    setState(() {});
  }

  void getRoute() async {
    DeliveryRoute route = DeliveryRoute(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );

    try {
      // getData() returns a json Decoded data
      data = await routeController.getData(route);
      //print(data);
      // We can reach to our desired JSON data manually as following
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      polyPoints = [];
      //markers = {};
      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    polyLines = {};
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
    );
    polyLines.add(polyline);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE94E1A),
      body: SafeArea(
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 26),
              child: Image.asset(
                'assets/images/motor.png',
                width: MediaQuery.of(context).size.width,
                height: 80,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                'Votre commande est en cours de Livraison',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFFE94E1A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 250,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(endLat, endLng),
                    zoom: 14,
                  ),
                  markers: markers,
                  polylines: polyLines,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Create a new class to hold the Co-ordinates we've received from the response data
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

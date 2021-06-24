import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:strong_delivery/controllers/AddressController.dart';
import 'package:strong_delivery/controllers/commandeController.dart';
import 'package:strong_delivery/models/ClientAddress.dart';
//import 'package:latlong/latlong.dart' as latLng;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:flutter_map/src/layer/marker_layer.dart' as m;
import 'package:strong_delivery/screens/payment_checkout.dart';

class LivraisonAdresse extends StatefulWidget {
  LivraisonAdresse({Key key}) : super(key: key);
  String adresse;
  @override
  _LivraisonAdresseState createState() => _LivraisonAdresseState();
}

class _LivraisonAdresseState extends State<LivraisonAdresse> {
  // MapController mapController = MapController();
  // UserLocationOptions userLocationOptions;
  //List<Marker> markers = [];
  CommandeController commandeController;
  TextEditingController adresseController;
  LatLng p;
  AddressController clientAddressController = AddressController();
  bool loading = false;
  bool _isGettingLocation = true;
  double lat = 0, lon = 0;
  String str = "Commander";
  MapController _mapController = MapController();
  ClientAdress clientAdress = ClientAdress();
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    try {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
        _isGettingLocation = false;
      });
    } on PlatformException catch (e) {
      print(e);
    }
    print('Current location lat long ' +
        position.latitude.toString() +
        " - " +
        position.longitude.toString());
  }

  @override
  void initState() {
    super.initState();
    adresseController = new TextEditingController(text: widget.adresse);
    commandeController = CommandeController();
    //getPosition();
    _isGettingLocation = true;
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 9),
                child: Text(
                  'Ajouter une adresse de livraison',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
                child: Text(
                  'Saisissez votre L\'addresse de livraison.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: TextFormField(
                      controller: adresseController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Quelle est votre adresse ?',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFD4D2D2),
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1F1F1F),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1F1F1F),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        filled: true,
                        fillColor: Color(0xFF1F1F1F),
                        contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFD4D2D2),
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.93, 0.54),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 25, 0, 0),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1, 0.40),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 10, 0),
                        child: IconButton(
                          color: Colors.deepOrange,
                          onPressed: () async {
                            setState(() async {
                              loading = true;
                              ClientAdress clientAdress =
                                  await clientAddressController
                                      .getLocationFromAddress(
                                          adresseController.text);
                              lat = clientAdress.getLatitude();
                              lon = clientAdress.getLongtitude();
                              _mapController.move(latlng.LatLng(lat, lon), 5);
                              loading = false;
                              str = 'commander';
                            });
                          },
                          icon: Icon(Icons.search),
                        )),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height - 350,
                      alignment: Alignment.centerLeft,
                      child: _isGettingLocation == false
                          ? FlutterMap(
                              mapController: _mapController,
                              options: MapOptions(
                                //maxZoom: 10,
                                //interactive: true,
                                onTap: (pos) async {
                                  setState(() async {
                                    lat = pos.latitude;
                                    lon = pos.longitude;
                                    adresseController.text =
                                        await clientAddressController
                                            .getAddressFromLocation(lat, lon);
                                    _mapController.move(
                                        latlng.LatLng(lat, lon), 5);
                                  });
                                },
                                zoom: 15.0,
                                center: latlng.LatLng(lat, lon),
                                minZoom: 10.0,
                              ),
                              layers: [
                                new TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c']),
                                new MarkerLayerOptions(markers: [
                                  m.Marker(
                                      width: 45.0,
                                      height: 45.0,
                                      point: latlng.LatLng(lat, lon),
                                      builder: (context) => new Container(
                                              child: IconButton(
                                            icon: Icon(Icons.location_on),
                                            color: Colors.redAccent[700],
                                            iconSize: 45.0,
                                            onPressed: () =>
                                                print("Marker pressed"),
                                          )))
                                ]),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              color: Colors.deepOrangeAccent,
                            )))),
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    Get.to(() => PaymentCheckout(
                          adresse: adresseController.text,
                          p: LatLng(lat, lon),
                        ));
                  },
                  child: loading == false
                      ? Text(
                          str,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.deepOrange,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

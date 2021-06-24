import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/User.controller.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:strong_delivery/screens/auth/space_screen.dart';
import 'package:strong_delivery/screens/home_screen.dart';
import 'package:strong_delivery/screens/new_commande.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const oneMin = const Duration(seconds: 90);
  new Timer.periodic(oneMin, (Timer t) {

    sendLocation();
  });
  runApp(MyApp());
}

sendLocation() async {
  //print("DKHAAAAAL");
  User user = await UserController().getUser();
  if (user.getRole() == "livreure") {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var response = await http.post(Uri.parse(Server.url + "location/store"),
        headers: <String, String>{
          
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer ' + token
        },
        body: {
          'longitud': position.longitude.toString(),
          'latitude': position.latitude.toString(),
        });
    if (response.statusCode == 200) {
      print("delivery man location had been sent to serve");
    } else {
      print(response.statusCode);
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token =  prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strong Delivery',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.white,
      ),
      //home: LivraisonAdresse(),
      home: token == null ? Space() : Dashboard(),
      routes: {
        '/notif': (context) => NewCommande(),
      },
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:strong_delivery/models/DeliveryRoute.dart';

class RouteController {
  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf62482f0a1127c7a04d6b82750636d7a67163'; // our api key we must get from databse hihiihi
  Future getData(DeliveryRoute route) async {
    http.Response response = await http.get(Uri.parse(
        '$url${route.journeyMode}?api_key=$apiKey&start=${route.startLng},${route.startLat}&end=${route.endLng},${route.endLat}'));
    print(
        '$url${route.journeyMode}?api_key=$apiKey&start=${route.startLng},${route.startLat}&end=${route.endLng},${route.endLat}');

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

import 'package:strong_delivery/models/ClientAddress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressController {
  Future<ClientAdress> getLocationFromAddress(String address) async {
    String serverUrl = 'https://nominatim.openstreetmap.org/search/';
    String format = "&limit=1&format=json";
    List<String> str = address.split(' ');
    String newAdress = str.join("%20");
    ClientAdress clientAdress = ClientAdress();
    print(serverUrl + "?q=" + newAdress + format);
    final response =
        await http.get(Uri.parse(serverUrl + "?q=" + newAdress + format));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body).length == 1)
        print(jsonDecode(response.body)[0]["display_name"]);
      ClientAdress clientAdress = ClientAdress(
          latitude: double.parse(jsonDecode(response.body)[0]["lat"]),
          longtitude: double.parse(jsonDecode(response.body)[0]["lon"]),
          nom: jsonDecode(response.body)[0]['display_name']);
      return clientAdress;
    } else {
      print(response.body);
      throw Exception(response.statusCode);
    }
  }

  Future<String> getAddressFromLocation(double lat, double lon) async {
    String serverUrl =
        'http://open.mapquestapi.com/geocoding/v1/reverse?key=1ryXFh5F0CiUGfqLephFgXJlgytBOZah&location=' +
            lat.toString() +
            "," +
            lon.toString() +
            "&includeRoadMetadata=true&includeNearestIntersection=true";

    final response = await http.get(Uri.parse(serverUrl));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)["results"][0]["locations"][0]["street"]);

      return jsonDecode(response.body)["results"][0]["locations"][0]["street"];
    } else {
      print(response.body);
      throw Exception(response.statusCode);
    }
  }
}

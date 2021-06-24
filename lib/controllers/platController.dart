import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/models/Plat.dart';
import 'package:http/http.dart' as http;

class PlatController extends GetxController {
  String token;
  Future<Map<String, dynamic>> getAllPlat() async {
    var map = Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    final response = await http.get(Uri.parse(Server.url + 'plat/get'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
          
        });
    if (response.statusCode == 200) {
      map = jsonDecode(response.body);
      //print(map[map.keys.toList()[0]][0]['image']);
      return map;
    } else {
      throw Exception(response.statusCode);
    }
  }
  Future<Map<String, dynamic>> getAllPlatOfRestaurant(int id) async {
    var map = Map<String, dynamic>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    final response = await http.get(Uri.parse(Server.url + 'plat/allByResto/'+id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      map = jsonDecode(response.body);
      //print(map[map.keys.toList()[0]][0]['image']);
      return map;
    } else {
      throw Exception(response.statusCode);
    }
  }
  Future getPlatById(int id) async {
    var map ;
    Plat p = new Plat();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    final response = await http.get(Uri.parse(Server.url + 'plat/get/'+id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token
        });
    if (response.statusCode == 200) {
      map = jsonDecode(response.body);
      p = Plat.fromJson(map);
      return p;
    } else {
      throw Exception(response.statusCode);
    }
  }

}

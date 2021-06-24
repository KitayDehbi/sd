import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:http/http.dart' as http;

class LivreureController{

  Future<dynamic> getLivreur(int id) async{
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print(token);
    final response = await http.get(
      Uri.parse(Server.url + "location/get/"+id.toString()),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    if(response.statusCode == 200){
      return [double.parse(jsonDecode(response.body)['latitude']),double.parse(jsonDecode(response.body)['longitud'])];
    }
    else throw Exception(response.statusCode);
  }
}
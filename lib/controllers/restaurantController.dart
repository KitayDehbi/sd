import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/AuthController.dart';
import 'package:strong_delivery/models/restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantController extends GetxController{
  final restaurant = Restaurant().obs;
  AuthController authController = AuthController();
  String token;

  
  Future<List<Restaurant>> getAllRestaurant() async{
    List<Restaurant>list = [];
   SharedPreferences prefs = await SharedPreferences.getInstance();
          token = await prefs.getString('token');
       //print('Bearer '+authController.getToken());
    final response =
      await http.get(Uri.parse(Server.url+'restaurant/allResto'),
       headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer '+token,
          
        }
      );
    if (response.statusCode == 200){
      var listJson =  jsonDecode( response.body);
      for(var item in listJson){
        //print(item);
        list.add(Restaurant.fromJson(item));
      }
    //print(list.length);
    }else{
       throw Exception(response.statusCode);
    }
    return list;
    
  }


}
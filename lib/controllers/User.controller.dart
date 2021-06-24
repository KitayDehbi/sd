import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:http/http.dart' as http;

class UserController {
  String token;
  Future<User> getUser() async {
    User user = new User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    final response = await http.get(Uri.parse(Server.url + 'auth/user'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token.toString()
        });
    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> updateUser(User u) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token');
    final response = await http.post(
      Uri.parse(Server.url + "auth/updateUserInfo"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(<String, String>{
        'name': u.getNom(),
        'email': u.getEmail(),
        'password': u.getPassword(),
        'adresse': u.getAdresse(),
        'role': u.getRole(),
        'rib': u.getRib(),
        'tel': u.getTel(),
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //print(response.body);
      return response.statusCode;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> switchState(String state) async {
    String str;
    if (state == 'available') {
      str = 'notAvailable';
    } else {
      str = 'available';
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token');
    final response = await http.post(
      Uri.parse(Server.url + "auth/changeAvailability"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(<String, String>{
        'availability': str,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //print(response.body);
      return jsonDecode(response.body)['status'];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }
}

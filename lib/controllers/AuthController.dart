import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/models/User.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:http/http.dart' as http;

class AuthController {
  String _token;
  String getToken() => _token;
  String _role;
  String getRole() => _role;
  int _status;
  int getStatus() => _status;
  Future<dynamic> authentication(String email, String password) async {
    final response = await http.post(
      Uri.parse(Server.url + "auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    _status = response.statusCode;
    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      _role = jsonDecode(response.body)['role'];
      await prefs.setInt('res_id', 0);
      await updateInstanceId();
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> updateInstanceId() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    var instanceID = await _firebaseMessaging.getToken();
    print(instanceID);
    final response = await http.post(
      Uri.parse(Server.url + "auth/instanceID"),
      headers: <String, String>{
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ' + _token,
      },
      body: <String, String>{
        'instance_id': instanceID,
      },
    );
    if (response.statusCode == 200) {
      print('l3ezzz');
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> signUp(String nom, String email, String password, String tel,
      String adresse, String rib) async {
    final response = await http.post(
      Uri.parse(Server.url + "auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Requested-With': "XMLHttpRequest"
      },
      body: jsonEncode(<String, String>{
        'nom': nom,
        'email': email,
        'password': password,
        'adresse': adresse,
        'tel': tel,
        'rib': rib,
      }),
    );
    _status = response.statusCode;
    //print (response.body);
    if (_status == 200) {
      //print(response.body);
      _token = jsonDecode(response.body)['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      return _status;
    } else {
      throw Exception('Erreur');
    }
  }
  // String token;
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // token = await prefs.getString('token');
  // final response = await http.post(
  //   Uri.parse(Server.url + "auth/instanceID"),
  //   headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ' + token,
  //   },
  //   body: jsonEncode(<String, String>{'instance_id': instanceID}),
  // );
  // _status = response.statusCode;
  // if (_status == 200) {
  //   print(response.body);
  // } else {
  //   throw Exception('Erreur');
  // }
}

import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strong_delivery/Statics/server.dart';
import 'package:strong_delivery/controllers/CartController.dart';
import 'package:strong_delivery/models/CartProduct.dart';
import 'package:strong_delivery/models/Commande.dart';
import 'package:http/http.dart' as http;
import 'package:strong_delivery/models/CommandeWithPlats.dart';
import 'package:strong_delivery/models/Paniers.dart';

class CommandeController {
  String token;
  Future<List<CommandeWithPlat>> getAllCommandesByUserId() async {
    List<CommandeWithPlat> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print('Bearer '+authController.getToken());
    Commande c = new Commande();
    List<Paniers> l = [];
    final response =
        await http.get(Uri.parse(Server.url + 'commands/userCmds'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      var listJson = jsonDecode(response.body);
      for (var item in listJson) {
        //print(item['cmd']);
        c = Commande.fromJson(item['cmd']);
        for (var i in item['paniers']) {
          l.add(Paniers.fromJson(i));
        }
        list.add(CommandeWithPlat(cmd: c, paniers: l));
        c = Commande();
        l = [];
      }
    } else {
      throw Exception(response.statusCode);
    }
    return list;
  }

  Future<dynamic> sendCommande(String adresse, LatLng p) async {
    List<CartProduct> plats = await CartController().getAllProduct();

    List<Object> l = [];
    plats.forEach((element) {
      l.add({"plat_id": element.plat_id, "occurrence": element.quantity});
    });
    var body = jsonEncode(<String, dynamic>{
      "adresse": adresse,
      "date": DateTime.now().toString(),
      "type_de_paiment": "visa",
      "plats": l,
      "longitude": p.longitude,
      "latitude": p.latitude,
    });
    print(body);
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    print(token);
    final response = await http.post(
      Uri.parse(Server.url + "commands/addCmd"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      await CartController().deleteAllProduct();
      return jsonDecode(response.body)["id"];
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> reserveCommande(int id) async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print(token);
    final response = await http.get(
      Uri.parse(Server.url + "commands/reserve/" + id.toString()),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      return 0;
    } else
      throw Exception(response.statusCode);
  }

  Future<List> getCommande(int commandeId) async {
    List<CartProduct> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body;
    var commandeInfo = {};
    token = prefs.getString('token');
    // token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYTQ1ZjUxNTM2ZDJlOWI2MjEwNGRjMjE5MjVkZjRiM2YxY2IyMjQ0NTc0YWQ5NWExODBjNDUzZjdjNzI0NzljNjBhODdmMDY0YWE4MzBiZWQiLCJpYXQiOjE2MjMzMzQ1MTksIm5iZiI6MTYyMzMzNDUxOSwiZXhwIjoxNjU0ODcwNTE5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.CnmH2QFxZpqrGm0fByP9h-oZiBPKvH_vvyX-xsHPvDFSpTVDXnhVliD21HwJ4z1bV-0p6jJS9EIvp4gdyRNmSPPF6npEj37yzF6B1sNgl7CdjAhhzNovLevjMzAf2W1bqUaWpsJ6gmYi0jCMeY7UzrwYrzoaA781q9BrCqj9ITKgjoefkt8fJcEN9_JeMCFK5mv1_WBOPBYefzFmpxtlmZkwTCCZKAXTHs78OvE0ZxaZVCt5pvs3DvSl6VeZITxJx4U_kcVVpaKYLlvmDqz2J4oS5cOK6iG5u4UndedQU3ffhDT-HiOePKoVx50dwUMUWxOErkLF6QTuRian-X4zc6mpcqBm_uMqyWgYilSI8icgNFTIlZnniqPfwaFO24YEyxb7WzZdbUih2CWhX5HHPl8lyHhG4r6D9V9j-_nwli9y268QOTS_H6JxEoaAvz9T70-rpHmwPxOD9nMal7cq9eChLF8iWgH9Y41C1U4UWqj0ExfGjzYct40vtJqVPvpB_toFs_DmqTSYDS7-7Bh1f0FOVFoyD_-30M_be8E6zugfoBpbQ1iLKsqL4Fhdkaes_M7mCef0aNAq9ZYv-nEgggapHD5iojVcHYqDq-I0FfhA3Hsdtu4krxkt2FC71lYGNLn1eHCDLFvpniJ7HFu0k46zv6BUnoJjKi0RnBhhkc4";
    final response = await http
        .get(Uri.parse(Server.url + 'commands/get/$commandeId'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token,
    });
    print(Server.url + 'commands/get/$commandeId');
    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
      commandeInfo["id"] = body["cmd"]["id"];
      commandeInfo["client_name"] = body["cmd"]["client"]["name"];
      commandeInfo["total_price"] = body["cmd"]["total"];
      commandeInfo["client_tel"] = body["cmd"]["client"]["tel"];
      commandeInfo["restaurant_name"] = body["cmd"]["resto"]["nom"];
      commandeInfo["client_long"] = body["cmd"]["longitude"];
      commandeInfo["client_lat"] = body["cmd"]["latitude"];
      commandeInfo["restaurant_long"] = body["cmd"]["resto"]["longitude"];
      commandeInfo["restaurant_lat"] = body["cmd"]["resto"]["latitude"];
      body["paniers"].forEach((panier) {
        list.add(CartProduct(
            name: panier["plat"]["nom"],
            image: panier["plat"]["image"],
            quantity: panier["occurrence"],
            plat_id: panier["plat"]['id'],
            price: double.parse(panier["plat"]["prix"].toString())));
      });
    } else {
      throw Exception(response.statusCode);
    }

    return [list, commandeInfo];
  }

  Future<dynamic> getStatefromId(int id) async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print(token);
    final response = await http.get(
      Uri.parse(Server.url + "commands/get/" + id.toString()),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["cmd"]["statut"];
    } else
      throw Exception(response.statusCode);
  }

  Future<dynamic> commandeGet(int id) async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print(token);
    final response = await http.get(
      Uri.parse(Server.url + "commands/get/" + id.toString()),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["cmd"];
    } else
      print(response.body);
    throw Exception(response.statusCode);
  }

  Future<dynamic> Livred(int id, double lat, double lon) async {
    String token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token');
    //print(token);
    final response = await http.post(
      Uri.parse(Server.url + "commands/dilevred"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      body: {
        'cmd_id': id,
        'longitude': lon,
        'latitude': lat,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["cmd"];
    } else
      throw Exception(response.statusCode);
  }
}

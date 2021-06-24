import 'package:strong_delivery/models/Plat.dart';

class Paniers {
  int _id, _commande_id, _occurance;
  Plat _plat;

  Paniers({int id, int commande_id, int occurrance, Plat plat}) {
    this._id = id;
    this._commande_id = commande_id;
    this._occurance = occurrance;
    this._plat = plat;
  }
  factory Paniers.fromJson(Map<String, dynamic> json) {
    return Paniers(
        commande_id: json["category_id"],
        id: json["id"],
        occurrance: json["occurrence"],
        plat: Plat.fromJson(json["plat"]));
  }
  int getId() => _id;
  int getCommandeId() => _commande_id;
  int getOccurance() => _occurance;
  Plat getPlat() => _plat;
}

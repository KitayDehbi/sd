import 'package:strong_delivery/models/Commande.dart';
import 'package:strong_delivery/models/Paniers.dart';

class CommandeWithPlat {

  Commande _cmd;
  List<Paniers> _paniers;

  CommandeWithPlat({Commande cmd,List<Paniers> paniers}){
    this._cmd= cmd;
    this._paniers= paniers;
  }

  factory CommandeWithPlat.fromJson(Map<String, dynamic> json){
      return CommandeWithPlat(cmd: json['cmd'] , paniers: json['paniers']);
  }
  Commande getCmd() => _cmd;
  List<Paniers> getPaniers() => _paniers;
}
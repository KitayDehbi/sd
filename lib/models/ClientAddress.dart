class ClientAdress{
  double _lat,_long;
  String _nom;

  ClientAdress({double latitude,double longtitude,String nom}){
    this._lat = latitude;
    this._long = longtitude;
    this._nom = nom;
  }

  factory ClientAdress.fromJson(Map<String ,dynamic> json){
    return ClientAdress(
      latitude: double.parse(json['lat']),
      longtitude: double.parse(json['lon']),
      nom: json['display_name'],
    );

  }

  double getLongtitude() => _long;
  double getLatitude() => _lat;
  String getNom() => _nom;

}
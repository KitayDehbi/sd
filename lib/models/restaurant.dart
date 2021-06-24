class Restaurant {
  int _id;
  String _image;
  String _nom;
  String _adresse;
  String _phone;
  String _description;
  String _openTime;
  String _closeTime;
  double _longtitude;
  double _latitude;
  int _user_id;
  DateTime _created_at;
  DateTime _updated_at;

  Restaurant({int id,String image, String nom , String adresse, String phone , String description,
    String openTime, String closeTime,double longtitude, double latitude, int user_id, DateTime created_at, DateTime updated_at, 
  }){
     this._id = id;
     this._image = image;
     this._nom = nom;
     this._adresse = adresse;
     this._phone = phone;
     this._description = description;
     this._openTime = openTime;
     this._closeTime = closeTime;
     this._longtitude = longtitude;
     this._latitude = latitude;
     this._user_id = user_id;
     this._created_at = created_at;
     this._updated_at = updated_at;


  }
  factory Restaurant.fromJson(Map<String, dynamic> json){
  return Restaurant(
       id: json['id'],
      image: json['image'],
      nom: json['nom'],
      adresse: json['adresse'],
      phone: json['phone'],
      description: json['description'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      // longtitude: json['longtitude'],
      // latitude: json['latitude'],
      // user_id: json['user_id'],
      // created_at: DateTime(json['created_at']),
      // updated_at: DateTime(json['updated_at']),
    );
}
  String getImage() => _image;
  String getNom() => _nom;
  int getId() => _id;



}



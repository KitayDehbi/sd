class Plat {
  int _id, _restaurant_id, _category_id;
  double _prix;
  String _nom, _description, _image;

  Plat({id, prix, nom, description, image, restaurant_id, category_id}) {
    this._id = id;
    this._nom = nom;
    this._prix = prix;
    this._description = description;
    this._image = image;
    this._category_id = category_id;
    this._restaurant_id = restaurant_id;
  }

  factory Plat.fromJson(Map<String, dynamic> json) {
    return Plat(
      id: json['id'],
      image: json['image'],
      nom: json['nom'],
      category_id: json['category_id'],
      restaurant_id: json['restaurant_id'],
      description: json['description'],
      prix: json['prix'].toDouble(),
      // closeTime: json['close_time'],
      // longtitude: json['longtitude'],
      // latitude: json['latitude'],
      // user_id: json['user_id'],
      // created_at: DateTime(json['created_at']),
      // updated_at: DateTime(json['updated_at']),
    );
  }
  String getImage() => _image;
  String getNom() => _nom;
  String getDescription() => _description;
  double getPrix() => _prix;
  int getId() => _id;
}

class User {
  int _id;
  String _name;
  String _email;
  String _photo;
  String _tel;
  String _rib;
  String _password;
  String _status;
  String _available;
  String _adresse;
  double _pourcentage;
  DateTime _created_at;
  DateTime _updated_at;
  String _role;
  User(
      {int id,
      String name,
      String email,
      String photo,
      String adresse,
      String tel,
      String rib,
      String password,
      String status,
      String available,
      double pourcentage,
      String role}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._photo = photo;
    this._tel = tel;
    this._rib = rib;
    this._password = password;
    this._adresse = adresse;
    this._status = status;
    this._available = available;
    this._pourcentage = pourcentage;
    this._role = role;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        photo: json['photo'],
        tel: json['tel'],
        rib: json['rib'],
        status: json['statut'],
        available: json['available'],
        //pourcentage: json['pourcentage'].toDouble(),
        password: json['password'],
        adresse: json['adresse'],
        role: json['role']);
  }
  String getNom() => _name;
  String getEmail() => _email;
  String getTel() => _tel;
  String getRib() => _rib;
  String getPassword() => _password;
  String getAdresse() => _adresse;
  String getRole() => _role;
  String getPhoto() => _photo;
  String getAvailable() => _available;
}

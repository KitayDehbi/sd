class Commande {
  int _id;
  String _date;
  double _prixTotale;
  Commande({int id, String date, double prixTotale}) {
    this._id = id;
    this._date = date;
    this._prixTotale = prixTotale;
  }

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      date: json['date'],
      prixTotale: json['total'].toDouble(),
    );
  }

  int getId() => _id;
  String getDate() => _date;
  double getPrix() => _prixTotale;
}



// List<Commande> commandes = [
//   Commande(1, DateTime(2020, 5, 2), 200),
//   Commande(1, DateTime(2020, 5, 2), 200),
//   Commande(1, DateTime(2020, 5, 2), 200),
//   Commande(1, DateTime(2020, 5, 2), 200),
//   Commande(2, DateTime(2020, 9, 12), 250),
//   Commande(3, DateTime(2020, 6, 8), 100),
//   Commande(4, DateTime(2020, 9, 30), 190),
// ];

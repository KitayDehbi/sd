class CartProduct {
  String name, image;
  int quantity, plat_id;
  double price;

  CartProduct({
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.plat_id,
  });

  CartProduct.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    image = map['image'];
    price = map['price'];
    quantity = map['quantity'];
    plat_id = map['plat_id'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'plat_id': plat_id,
    };
  }
}

// List<Paniers> demoCart = [
//   Paniers(
//       id: 1,
//       commande_id: 1,
//       occurrance: 2,
//       plat: Plat(
//           id: 1,
//           category_id: 1,
//           description: "test",
//           image:
//               "https://resize-elle.ladmedia.fr/r/625,,forcex/crop/625,625,center-middle,forcex,ffffff/img/var/plain_site/storage/images/elle-a-table/les-dossiers-de-la-redaction/news-de-la-redaction/ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer-3679031/86933159-2-fre-FR/Ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer.jpg",
//           nom: "makla",
//           prix: 15.25,
//           restaurant_id: 1)),
//   Paniers(
//       id: 2,
//       commande_id: 1,
//       occurrance: 2,
//       plat: Plat(
//           id: 2,
//           category_id: 1,
//           description: "test",
//           image:
//               "https://resize-elle.ladmedia.fr/r/625,,forcex/crop/625,625,center-middle,forcex,ffffff/img/var/plain_site/storage/images/elle-a-table/les-dossiers-de-la-redaction/news-de-la-redaction/ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer-3679031/86933159-2-fre-FR/Ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer.jpg",
//           nom: "makla",
//           prix: 15.25,
//           restaurant_id: 1)),
//   Paniers(
//       id: 3,
//       commande_id: 1,
//       occurrance: 2,
//       plat: Plat(
//           id: 3,
//           category_id: 1,
//           description: "test",
//           image:
//               "https://resize-elle.ladmedia.fr/r/625,,forcex/crop/625,625,center-middle,forcex,ffffff/img/var/plain_site/storage/images/elle-a-table/les-dossiers-de-la-redaction/news-de-la-redaction/ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer-3679031/86933159-2-fre-FR/Ces-plats-sont-plus-rapides-a-preparer-qu-a-faire-livrer.jpg",
//           nom: "makla",
//           prix: 15.25,
//           restaurant_id: 1)),
// ];

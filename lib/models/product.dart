class Product {
  int productId, price;
  String title, description, image;
  Product({this.productId, this.price, this.title, this.description, this.image});


  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    productId = map['productId'];
    title = map['title'];
    image = map['image'];
    price = map['price'];
    description = map['description'];
  }

  toJson() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
    };
  }
}

List<Product> products = [
  Product(
    productId: 1,
    price: 10,
    title: "Mélange pour chocolat chaud",
    description: "Mélange pour chocolat chaud Mélange pour chocolat chaud Mélange pour chocolat chaud Mélange pour chocolat chaud Mélange pour chocolat chaud",
    image: "https://i.pinimg.com/originals/b3/e8/2b/b3e82bf4337d40383b4b3ee788ce8bc1.jpg",
  ),
  Product(
    productId: 2,
    price: 20,
    title: "Carrés s’mores",
    description: "Carrés s’mores",
    image: "https://i.pinimg.com/originals/d4/0d/61/d40d61f105f755125b4d259fcc27d7b4.jpg",
  ),
  Product(
    productId: 3,
    price: 30,
    title: "Carrés à l’érable et aux noisettes",
    description: "Carrés à l’érable et aux noisettes",
    image: "https://previews.123rf.com/images/tiverylucky/tiverylucky1312/tiverylucky131200113/24536021-un-plat-de-luxe-de-homard-r%C3%B4ti-et-d%C3%A9cor%C3%A9-avec-de-nombreux-%C3%A9l%C3%A9ments-d-origine-v%C3%A9g%C3%A9tale.jpg",
  ),
  Product(
    productId: 4,
    price: 40,
    title: "Tacos aux lentilles et au bœuf",
    description: "Chawarma gega",
    image: "https://images.ricardocuisine.com/services/recipes/1074x1074_7553-cover.jpg",
  ),
];
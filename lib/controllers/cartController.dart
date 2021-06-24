import 'package:strong_delivery/controllers/DatabaseController.dart';
import 'package:strong_delivery/models/CartProduct.dart';

class CartController {
  List<CartProduct> _cartProduct = [];
  double _totalPrice = 0.0;

  getAllProduct() async {
    var dbHelper = DatabaseController.db;
    _cartProduct = await dbHelper.getAllProduct();
    print("this is _cartProduct len: ${_cartProduct.length}");
    return _cartProduct;
  }

  addProduct(CartProduct cartProduct) async {
    var isAlreadyInCart = false;
    await getAllProduct();
    for (int i = 0; i < _cartProduct.length; i++) {
      if (_cartProduct[i].plat_id == cartProduct.plat_id) {
        isAlreadyInCart = true;
        break;
      }
    }
    if (!isAlreadyInCart) {
      var dbHelper = DatabaseController.db;
      await dbHelper.insert(cartProduct);
    }
    // getTotalPrice();
  }

  update(int plat_id, int quantity) async {
    var db = DatabaseController.db;
    await db.update(plat_id, quantity);
  }

  deleteProduct(int id) async {
    var dbHelper = DatabaseController.db;
    await dbHelper.delete(id);
  }

  deleteAllProduct() async {
    var db = DatabaseController.db;
    await db.deleteAll();
  }

  getTotalPrice() async {
    var products = await getAllProduct();
    _totalPrice = 0;
    for (int i = 0; i < products.length; i++) {
      _totalPrice += (products[i].price * products[i].quantity);
    }
    return _totalPrice;
  }

  List<CartProduct> get cartProduct => _cartProduct;

  double get totalPrice => _totalPrice;
}

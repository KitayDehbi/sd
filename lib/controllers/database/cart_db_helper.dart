import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:strong_delivery/constance.dart';
import 'package:strong_delivery/models/cart_product.dart';

class CartDataBaseHelper {
  CartDataBaseHelper._();

  static final CartDataBaseHelper db = CartDataBaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CardProduct.db');
    // return await deleteDatabase(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableCartProduct (
      $name TEXT NOT NULL,
      $image TEXT NOT NULL,
      $price TEXT NOT NULL,
      $quantity INTEGER NOT NULL,
      $productId INTEGER NOT NULL
      )
      ''');
    });
  }

  Future<List<CartProduct>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableCartProduct);

    List<CartProduct> list = maps.isNotEmpty
        ? maps.map((product) => CartProduct.fromJson(product)).toList()
        : [];

    return list;
  }

  insert(CartProduct model) async {
    var dbClient = await database;

    await dbClient.insert(tableCartProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:strong_delivery/models/CartProduct.dart';

class DatabaseController {
  DatabaseController._();

  static final DatabaseController db = DatabaseController._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    // return await deleteDatabase(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS Carts(
      name TEXT NOT NULL,
      image TEXT NOT NULL,
      price DOUBLE NOT NULL,
      quantity INTEGER NOT NULL,
      plat_id INTEGER NOT NULL
      )
      ''');
    });
  }

  Future<List<CartProduct>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query("Carts");

    List<CartProduct> list = maps.isNotEmpty
        ? maps.map((product) => CartProduct.fromJson(product)).toList()
        : [];

    return list;
  }

  insert(CartProduct model) async {
    var dbClient = await database;

    await dbClient.insert("Carts", model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  delete(int id) async {
    var dbClient = await database;

    return await dbClient
        .delete("Carts", where: 'plat_id = ?', whereArgs: [id]);
  }

  deleteAll() async {
    var dbClient = await database;

    return await dbClient.delete("Carts");
  }

  update(int plat_id, int quantity) async {
    var dbClient = await database;

    return await dbClient.update(
        "Carts", <String, Object>{"quantity": quantity},
        where: 'plat_id = ?', whereArgs: [plat_id]);
  }
}

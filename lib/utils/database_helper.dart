import 'dart:io';
import 'package:redcar/models/car.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Car(id INTEGER PRIMARY KEY, title TEXT, opening_crawl TEXT,director TEXT,producer TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveCar(Car car) async {
    var dbClient = await db;
    int res = await dbClient.insert("Film", car.toMap());
    return res;
  }

  //deletion
  Future<int> deleteCar(Car film) async {
    var dbClient = await db;
    int res = await dbClient.delete("Film");
    return res;
  }


  Future<List<Car>> getCars() async {
    var dbClient = await db;
    var result = await dbClient.query("Film", columns: ["title","opening_crawl","director","producer"]);

    List<Car> films = result.map((f) => Car.fromMap(f)).toList();
    return films;

  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
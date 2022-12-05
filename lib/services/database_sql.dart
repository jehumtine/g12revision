// import 'dart:io';
// import 'package:estudiee/models/add_to_favorites.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();
//   Future<Database> _initDatabase() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'names.db');
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''CREATE TABLE names(
//       id INTEGER PRIMARY KEY,
//       name TEXT,
//       url TEXT
//     )''');
//   }

//   Future<List<FavoriteItem>> getNames() async {
//     Database db = await instance.database;
//     var names = await db.query('names', orderBy: 'name');
//     List<FavoriteItem> favoriteList = names.isNotEmpty
//         ? names.map((c) => FavoriteItem.fromMap(c)).toList()
//         : [];
//     return favoriteList;
//   }

//   Future<int> add(FavoriteItem favoriteItem) async {
//     Database db = await instance.database;
//     return await db.insert('names', favoriteItem.toMap());
//   }

//   Future<int> remove(int id) async {
//     Database db = await instance.database;
//     return await db.delete('names', where: 'id = ?', whereArgs: [id]);
//   }
// }

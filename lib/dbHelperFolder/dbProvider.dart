import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aio4getco/data/conductorImpedanceList.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'getco_data.db'),
        onCreate: (db, version) async {
      await db.execute('''
       CREATE TABLE conductor_data ( 
         id INTEGER PRIMARY KEY, 
         conductor_name TEXT, 
         positiveSequenceResistance TEXT, 
         positiveSequenceReactance TEXT, 
         positiveSequenceImpedance TEXT,       
         positiveSequenceAngle TEXT, 
         zeroSequenceResistance TEXT,
         zeroSequenceReactance TEXT,
         zeroSequenceImpedance TEXT,
         zeroSequenceAngle TEXT)''');
    }, version: 1);
  }

  newConductor(ConductorSqliteData newConductor) async {
    final db = await database;
    var res = await db.rawInsert('''
    INSERT INTO conductor_data (
      conductor_name ,
          positiveSequenceResistance ,
          positiveSequenceReactance ,
          positiveSequenceImpedance ,
          positiveSequenceAngle ,
          zeroSequenceResistance ,
          zeroSequenceReactance ,
          zeroSequenceImpedance ,
          zeroSequenceAngle
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      newConductor.nameConuctor,
      newConductor.positiveSequenceResistance,
      newConductor.positiveSequenceReactance,
      newConductor.positiveSequenceImpedance,
      newConductor.positiveSequenceAngle,
      newConductor.zeroSequenceResistance,
      newConductor.zeroSequenceReactance,
      newConductor.zeroSequenceImpedance,
      newConductor.zeroSequenceAngle
    ]);

    return res;
  }

  Future<List<ConductorSqliteData>> getConductor() async {
    final db = await database;
    var res = await db.query("conductor_data");
    List<ConductorSqliteData> list = res.isNotEmpty
        ? res.map((c) => ConductorSqliteData.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteConductor(int id) async {
    final db = await database;
    db.delete("conductor_data", where: "id = ?", whereArgs: [id]);
  }
}

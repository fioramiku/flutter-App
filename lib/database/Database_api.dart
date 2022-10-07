import 'dart:developer';

import 'dart:io';

import 'package:abc/database/Repository_Database.dart';
import 'package:abc/views/me_page/bloc/profile_bloc.dart';
import 'package:abc/views/plan_main/bloc/timemanage_bloc.dart';
import 'package:abc/views/todo_page/bloc/todolist_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../views/me_page/cubit/chart_cubit.dart';

class Database_api {
  dynamic getState(int key) {
    switch (key) {
      case 0:
        return ProfileState;
    }
  }

  Database_api({this.dbname = "data.db"});

  String? dbname;

  Future<Database> dbopen() async {
    Directory appdirectory = await getApplicationDocumentsDirectory();
    var dblocate = join(appdirectory.path, dbname);

    DatabaseFactory dataFactory = databaseFactoryIo;
    Database db = await dataFactory.openDatabase(dblocate);

    return db;
  }
  //profile 0,todo 1,timemanange 2,chart 3

  dbAdd(dynamic database, int keyId) async {
    var db = await dbopen();
    var store = intMapStoreFactory.store(keyId.toString());
    log('message');
    if (database is ProfileState) {
      await store.record(keyId).put(db, database.toMap());
      print("put");
    }
    if (database is BuildTodoState) {
      var check = await store.record(keyId).put(db, database.toMap());
      log(database.toMap().toString());
    }
    if (database is BuildClockState) {
      await store.record(keyId).put(db, database.toMap());
    }
    if(database is ChartBuildState ){
      await store.record(keyId).put(db, database.data );

    }
    db.close();
  }

  Future<dynamic> dbload(int keyId) async {
    var db = await dbopen();
    var store = intMapStoreFactory.store(keyId.toString());
    log(db.path);

    var record = await store.record(keyId).get(db);
    late var database;
    switch (keyId) {
      case 0:
        database = ProfileState.fromMap(
            record != null ? record as Map<String, dynamic> : {});
        break;
      case 1:
        database = BuildTodoState.fromMap(
            record != null ? record as Map<String, dynamic> : {});
        break;
      case 2:
        database = BuildClockState.formMap(
            record != null ? record as Map<String, dynamic> : {});
        break;
      case 3:
        database = ChartBuildState.fromMap( (record??{}) as Map<String,dynamic>);
        
        break;
      default:
        database = null;
    }

    return database;
  }
}

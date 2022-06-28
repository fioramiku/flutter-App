import 'dart:io';

import 'package:abc/views/me_page/bloc/profile_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class transection_data {
  String? dbname;
  transection_data({this.dbname});

  Future<Database> dbopen() async {
    Directory appdirectory = await getApplicationDocumentsDirectory();
    var dblocate = join(appdirectory.path, dbname);

    DatabaseFactory dataFactory = await databaseFactoryIo;
    Database db = await dataFactory.openDatabase(dblocate);
    return db;
  }

  Future<int> Changedata(ProfileState profile) async {
    var db = await this.dbopen();
    var store = intMapStoreFactory.store("profile");

    var keyID = store.add(db, {"name": profile.name, "email": profile.email});
    return keyID;
  }

  Future<ProfileState> load_data() async {
    var db = await this.dbopen();
    var store = intMapStoreFactory.store("profile");
    var snapshot = await store.find(db);

    ProfileState profile = new ProfileState(name: "");

    for (var record in snapshot) {
      profile = ProfileState(
          name: record.value["name"].toString(),
          email: record.value["email"].toString());
    }

    return profile;
  }
}

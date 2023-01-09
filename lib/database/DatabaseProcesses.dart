import 'package:capollon_app/database/DataBaseHelper.dart';

class DatabaseProcesses{

  Future <void> addFavoriteCoin(String id) async{
    var db = await DatabaseHelper.databaseAccess();

    var values = Map<String, dynamic>();
    values["id"] = id;
    
    await db.insert("favorites", values);
  }

  Future <void> deleteFavoriteCoin(String id) async{
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("favorites", where: "id = ?", whereArgs: [id]);
  }

  Future <bool> containsCoin(String id) async{
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT count(*) AS result FROM favorites WHERE id = '$id'");

    int value = maps[0]["result"];

    if(value == 1){
      return true;
    }else{
      return false;
    }
  }

}
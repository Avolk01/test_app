import 'package:register_page/assets/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  SharedPrefController();

  Future<bool> rightUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _uid = prefs.getString(FieldsStrings.uid);
    if (_uid == null) {
      return false;
    } else {
      return _uid == uid;
    }
  }

  void saveData(List<int> counterValues, String uid, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(FieldsStrings.blin, counterValues[0]);
    prefs.setInt(FieldsStrings.suicide, counterValues[1]);
    prefs.setInt(FieldsStrings.giveUp, counterValues[2]);
    prefs.setInt(FieldsStrings.chetko, counterValues[3]);
    prefs.setString(FieldsStrings.uid, uid);
    prefs.setString(FieldsStrings.date, date);
  }

  void setString(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void setInt(String key, int value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<List<int>> loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> databaseValues = [];
    databaseValues.add(prefs.getInt(FieldsStrings.blin)!);
    databaseValues.add(prefs.getInt(FieldsStrings.suicide)!);
    databaseValues.add(prefs.getInt(FieldsStrings.giveUp)!);
    databaseValues.add(prefs.getInt(FieldsStrings.chetko)!);
    return databaseValues;
  }
}

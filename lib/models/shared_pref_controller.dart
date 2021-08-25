import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  SharedPrefController();

  Future<bool> rightUser(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _uid = prefs.getString('uid');
    if (_uid == null) {
      return false;
    } else {
      return _uid == uid;
    }
  }

  void saveData(List<int> counterValues, String uid, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('blin', counterValues[0]);
    prefs.setInt('suicide', counterValues[1]);
    prefs.setInt('giveUp', counterValues[2]);
    prefs.setInt('chetko', counterValues[3]);
    prefs.setString('uid', uid);
    prefs.setString('date', date);
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
    databaseValues.add(prefs.getInt('blin')!);
    databaseValues.add(prefs.getInt('suicide')!);
    databaseValues.add(prefs.getInt('giveUp')!);
    databaseValues.add(prefs.getInt('chetko')!);
    return databaseValues;
  }
}

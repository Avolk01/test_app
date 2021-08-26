import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:register_page/assets/strings.dart';

class FirebaseController {
  FirebaseController(
      {required this.mainCollection, required this.optionalCollection});

  final String mainCollection;
  final String optionalCollection;

  Future<List<int>> initFieldsFromDatabase(String uid, String time) async {
    List<int> result = [];

    if (await isNewDate(uid, time))
      addNewDate(uid, time);

    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .get()
        .then((value) {
      result.add(value[FieldsStrings.blin]);
      result.add(value[FieldsStrings.suicide]);
      result.add(value[FieldsStrings.giveUp]);
      result.add(value[FieldsStrings.chetko]);

    });
    return result;
  }

  void updateDatabase(String uid, String time, List<int> values) async {
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .update({
      FieldsStrings.blin: values[0],
      FieldsStrings.suicide: values[1],
      FieldsStrings.giveUp: values[2],
      FieldsStrings.chetko: values[3],
    });
  }

  void createNewUser(String uid, String time) async {
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .set({FieldsStrings.blin: 0, FieldsStrings.suicide: 0, FieldsStrings.giveUp: 0, FieldsStrings.chetko: 0});
  }

  Future<void> addNewDate(String uid, String time) async {
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .set({FieldsStrings.blin: 0, FieldsStrings.suicide: 0, FieldsStrings.giveUp: 0, FieldsStrings.chetko: 0});
  }

  Future<bool> isNewDate(String uid, String time) async {
   var x = await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection).get();
   try{
     x.docs.firstWhere((element) => element.id == time);
     return false;
   } catch (_){
     return true;
   }
  }


  String dateToString(QueryDocumentSnapshot<Map<String, dynamic>> date) {
    return date.id.toString();
  }

  Future<List<String>> getListOfDates(String uid) async {
    List<String> result = [];
    var dates = await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .get();
    dates.docs.forEach(
      (element) {
        result.add(dateToString(element));
      },
    );
    return result;
  }

  Future<List<DateTime>> getListOfDateTime(String uid) async {
    List<DateTime> result = [];
    var dates = await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .get();
    dates.docs.forEach(
      (element) {
        result.add(DateTime.parse(element.id));
      },
    );
    return result;
  }

  Future<List<int>> getValues(String uid, String date) async {
    List<int> result = [];
    var values = await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(date)
        .get();
    values.data()!.forEach(
      (key, value) {
        result.add(value);
      },
    );
    return result;
  }

  Future<List<int>> getClicks(String uid, List<String> dates) async {
    List<int> result = [];
    for (var elem in dates) {
      var x = await getValues(uid, elem);
      int sum = 0;
      x.forEach((element) {
        sum += element;
      });
      result.add(sum);
    }
    return result;
  }
}

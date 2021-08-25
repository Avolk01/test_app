import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  FirebaseController(
      {required this.mainCollection, required this.optionalCollection});

  final String mainCollection;
  final String optionalCollection;

  Future<List<int>> initFieldsFromDatabase(String uid, String time) async {
    List<int> result = [];
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .get()
        .then((value) {
      result.add(value['blin']);
      result.add(value['chetko']);
      result.add(value['giveUp']);
      result.add(value['suicide']);
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
      'blin': values[0],
      'suicide': values[1],
      'giveUp': values[2],
      'chetko': values[3],
    });
  }

  void createNewUser(String uid, String time) async {
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .set({'blin': 0, 'suicide': 0, 'giveUp': 0, 'chetko': 0});
  }

  void addNewDate(String uid, String time) async {
    await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(uid)
        .collection(optionalCollection)
        .doc(time)
        .set({'blin': 0, 'suicide': 0, 'giveUp': 0, 'chetko': 0});
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

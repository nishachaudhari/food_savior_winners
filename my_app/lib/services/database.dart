import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

final String uid;
DatabaseService({this.uid});

//collection reference

final CollectionReference userAccountCollection = Firestore.instance.collection('users');

Future updateUserData(String firstName, String lastName, String phone) async {
  return await userAccountCollection.document(uid).setData({
    'firstName' :firstName,
    'lastName' :lastName,
    'phoneNumber': phone,

  });
}


}
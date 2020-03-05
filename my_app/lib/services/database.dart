import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';


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

// user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['first name'],
      lastName: snapshot.data['last name'],
      phone: snapshot.data['phone']
    );
  }
  // get user doc stream

  Stream <UserData> get userData{
    return userAccountCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}

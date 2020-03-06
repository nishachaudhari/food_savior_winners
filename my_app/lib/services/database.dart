import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/food.dart';
import 'package:my_app/models/user.dart';


class DatabaseService {

final String id;
DatabaseService({this.id});

//collection reference

final CollectionReference userAccountCollection = Firestore.instance.collection('users');

Future updateUserData(String firstName, String lastName, String phone) async {
  return await userAccountCollection.document(id).setData({
    'firstName' :firstName,
    'lastName' :lastName,
    'phoneNumber': phone,
 });
}

// user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: id,
      firstName: snapshot.data['first name'],
      lastName: snapshot.data['last name'],
      phone: snapshot.data['phone']
    );
  }
  // get user doc stream

  Stream <UserData> get userData{
    return userAccountCollection.document(id).snapshots()
      .map(_userDataFromSnapshot);
  }


  //FOOD COLLECTION

  final CollectionReference foodCollection = Firestore.instance.collection('food');

  Future updatefoodData(String user, String title, String amount, String location, String description, String time) async {
  return await foodCollection.document().setData({
    'user' : user,
    'title' :title,
    'amount' :amount,
    'location': location,
    'description': description,
     'time': time
 });
}

/*Food _foodDataFromSnapshot(DocumentSnapshot snapshot) {
    return Food(
      foodID: id,
      title: snapshot.data['first name'],
      amount: snapshot.data['last name'],
      location: snapshot.data['phone'],
      description: snapshot.data['description'],
      time: snapshot.data['time']

    );
  }

Stream <Food> get foodData{
  return foodCollection.document().snapshots()
    .map(_foodDataFromSnapshot);
}
*/

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/food.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/models/message.dart';


class DatabaseService {

final String id;
DatabaseService({this.id});

//collection reference

final CollectionReference userAccountCollection = Firestore.instance.collection('users');


Future updateUserData(String firstName, String lastName, String phone, String photo) async {
  return await userAccountCollection.document(id).setData({
    'firstName' :firstName,
    'lastName' :lastName,
    'phoneNumber': phone,
    'photo':photo
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

  Future updatefoodData(String user, String title, String amount, String location, String description, String cuisine, String time, String date, String photo, String order, String eater) async {
  return await foodCollection.document().setData({
    'user' : user,
    'title' :title,
    'amount' :amount,
    'location': location,
    'description': description,
    'cuisine':cuisine,
    'time': time,
    'date': date,
    'photo': photo,
    'order': order, //default order status-> goes to pending -> claimed -> picked up
    'eater' : eater, //default person who claimed food -> goes to user id of pending person -> uid of claimer
 });
}

Future editfoodData(String user, String title, String amount, String location, String description, String cuisine, String time, String date, String photo) async {
  return await foodCollection.document(id).updateData({
    'user' : user,
    'title' :title,
    'amount' :amount,
    'location': location,
    'description': description,
    'cuisine':cuisine,
    'time': time,
    'date': date,
    'photo':photo,

 });
}

Future editfoodStatus(String eater, String orderStatus) async{
return await foodCollection.document(id).updateData({
  'order': orderStatus,
  'eater': eater,
}
);
}

//FOOD COLLECTION

  final CollectionReference requestCollection = Firestore.instance.collection('request');

  Future updaterequestData(String user, String eater, String foodID, String status) async {
  return await requestCollection.document().setData({
    'user' : user,
    'eater' : eater,
    'foodID' : foodID,
    'status' : status,
 });
}

Future updaterequestStatus(String status) async {
  return await requestCollection.document(id).updateData({
    'status' : status,
 });
}

//CONVO COLLECTION

final CollectionReference convoCollection = Firestore.instance.collection('convo');

Future updateConversation(String client, String host, String food) async {
  var roomName = client+'_'+host;
  return await convoCollection.document(roomName).setData({
    'clientID' : client,
    'hostID' : host,
    'currFood' : food,
  });
}

// String getUsername(String userID) async {

// }


Future addMessage(Message message) async {

}

// Future getUsername(String uid) async {
//   var userDocumentSnapshot = await convoCollection.document(uid).get().then;
//   if(userDocumentSnapshot.documents.isNotEmpty){
//     return userDocumentSnapshot.documents
//   }
// }




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

import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:my_app/models/user.dart';
import 'package:my_app/services/database.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on firebase user
User _userFromFirebaseUser(FirebaseUser user){
  return user != null ? User(uid: user.uid) : null;

}

//auth change user stream:: stream that says if user is signed in or not using firebase functionality
 
Stream <User> get user{   //returns user everytime auth state changes if signing in and null if signing out

  return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);  //takes info from firebase user and puts it in our user model

}

 
//sign in google


//sign in email
Future signInEmail(String email, String password) async{
  try {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }
  catch (e){
    print(e.toString());
    return null;
  }
}





//register email
Future registerEmail(String email, String password) async{
  try {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
//create new doc for user in database

    await DatabaseService(id: user.uid).updateUserData('first', 'last', 'phone', 'photo');

    return _userFromFirebaseUser(user);

  }
  catch (e){
    print(e.toString());
    return null;
  }
}


//sign out

Future signOut() async {
  try{
    return await _auth.signOut();
  }
  catch(e) {
    print(e.toString());
    return null;
  }

}



}

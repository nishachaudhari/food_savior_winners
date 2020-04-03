import 'package:flutter/material.dart';
//import 'package:my_app/services/auth.dart';
import 'package:my_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/user.dart';
import 'dart:io';
import 'package:my_app/screens/add/image_picker_handler.dart';
import 'dart:convert';

class accountForm extends StatefulWidget
{
  @override
  _accountFormState createState() => _accountFormState();
  }

class _accountFormState extends State<accountForm>
    with TickerProviderStateMixin,ImagePickerListener{

  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //this will be able to track state of form (to make sure no blank items)


  //text field state

  String _currentFirstName = '';
  String _currentLastName = '';
  String _currentPhone = '';
  String _currentPhoto = '';
  String error = '';

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(this,_controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    void _showDialog(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Account Successfully Updated!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }

    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel",
            textAlign: TextAlign.center,
            //style: style.copyWith(
               // color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      )
    );




    return StreamBuilder<UserData>(
      stream: DatabaseService(id:user.uid).userData,
      builder:(context,snapshot){
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Scaffold (
            body: Container (
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => imagePicker.showDialog(context),
                        child: Center(
                          child: _image == null
                            ? Stack(
                              children: <Widget>[
                                Center(
                                  child: CircleAvatar(
                                    radius: 80.0,
                                    backgroundColor: Color(0xFF778899),
                                  ),
                                ),
                                Center(
                                  child: Icon(Icons.photo_camera),
                                ),
                              ],
                            )
                            : Container(
                                height: 160.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                  color: Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: ExactAssetImage(_image.path),
                                    fit: BoxFit.cover,
                                  ),
                                  border:
                                      Border.all(color: Colors.red, width: 5.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                ),
                            ),
                        ),
                      ),
                      SizedBox (height:30),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter a First Name' : null,
                        onChanged: (val){
                          setState(()=>_currentFirstName= val);
                        },
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "First Name",
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                        ) ,
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        validator: (val) => val.isEmpty ? 'Enter a Last Name' : null,
                        onChanged: (val){
                          setState(()=>_currentLastName = val);
                        },
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Last Name",
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                        ) ,
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        validator: (val) => val.length<10 ? 'Enter a valid Phone Number' : null,
                        onChanged: (val){
                          setState(()=>_currentPhone = val);
                        },
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Phone Number",
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                        ) ,
                      ),
                      SizedBox(height: 45.0),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.green,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          child: Text("Update Information",
                              textAlign: TextAlign.center,
                              //style: style.copyWith(
                                // color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                          onPressed:()async{
                            String base64Image = base64Encode(File(_image.path).readAsBytesSync());
                            if (_formKey.currentState.validate())
                            {
                              await DatabaseService(id:user.uid).updateUserData(
                                _currentFirstName ?? snapshot.data.firstName,
                                _currentLastName ?? snapshot.data.lastName,
                                _currentPhone ?? snapshot.data.phone,
                                base64Image);
                            }
                            Navigator.pop(context);
                            _showDialog();
                          }
                        )

                      ),
                      SizedBox(height: 45.0),
                      backButton,
                      SizedBox(height: 20.0),
                      Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
                    ],
                  ),
                ),
              ),
            )
          );
        } else {
          return Container();
        }
      }
    );
  }
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}

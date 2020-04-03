import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/models/food.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:my_app/screens/add/image_picker_handler.dart';
import 'package:my_app/services/database.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyDwh7H9FYJmquCsq3evvZEEtePM_uQYpcU");

class addForm extends StatefulWidget 
{ 
  @override
  _addFormState createState() => _addFormState();
  }

class _addFormState extends State<addForm>
    with TickerProviderStateMixin,ImagePickerListener{

  final _formKey = GlobalKey<FormState>(); //this will be able to track state of form (to make sure no blank items)
  
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  TimeOfDay selectedTime =TimeOfDay.now();
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, 
        builder: (BuildContext context, Widget child) {
           return MediaQuery(
             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );});

    if (picked_s != null && picked_s != selectedTime )
      setState(() {
        selectedTime = picked_s;
      });
  }

  //text field state

  
  String _currenttitle = '';
  String _currentamount = 'Serving Size';
  String _currentlocation = '';
  String _currentdescription = '';
  String _currenttime = '';
  String _currentdate = '';
  String tags = '';
  String error = '';
  String addr = 'Location';

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  TextEditingController _textController = TextEditingController(text: "Location");

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
    String _currentuser = user.uid;
    //Food food = Provider.of<Food>(context);

    Food food;

    void _showDialog(){
      showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Food Successfully Added!"),
          content: new Text("Go to messages to see new requests."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Got it!"),
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
            child: Text("Back",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );


      return Scaffold(
        body:Container (
          child:Padding(
            padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      SizedBox(height: 20.0),  
                      TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter a Title' : null,
                          onChanged: (val){
                            setState(()=>_currenttitle = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Title",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 20.0),
                        DropdownButton(
                          value: _currentamount,
                          onChanged: (val){
                            setState(()=>_currentamount = val, );
                          },
                          iconSize: 30,
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                           items: <String>['Serving Size', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '10+']
                              .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  );
                                })
                              .toList(), 
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          //validator: (val) => val.isEmpty ? 'Enter a Location' : null,
                          //onChanged: (val){
                          //  setState(()=>_currentlocation = val);
                          //},
                          controller: _textController,
                          onTap: ()async{
                            Prediction p = await PlacesAutocomplete.show(context:context, apiKey:"AIzaSyDwh7H9FYJmquCsq3evvZEEtePM_uQYpcU",
                            language: "en", components: [
                              Component(Component.country, "usa")
                            ],
                            radius : 100000, 
                            );
                            if (p != null) {
                              PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
                              _currentlocation = detail.result.formattedAddress;
                              addr = detail.result.formattedAddress;
                              _textController.text = addr;
                            }
                          },
                          
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          //hintText: addr,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) => val.length>500 ? 'Enter a Description less than 500 characters' : null,
                          onChanged: (val){
                            setState(()=>_currentdescription = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Description",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 20.0),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                        
                      ),
                      Text("${selectedTime}"),
                      RaisedButton(
                        onPressed: () =>_selectTime(context),
                        child: Text('Select time'),
                      ),
                        /*TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter some tags' : null,
                          onChanged: (val){
                            setState(()=>tags = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Tags",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        */
                        SizedBox(height: 30.0),
                        Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.green,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                child: Text("Add Food",
                                    textAlign: TextAlign.center,
                                    //style: style.copyWith(
                                      // color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                                onPressed:()async{
                                  String base64Image = base64Encode(File(_image.path).readAsBytesSync());
                                  if (_formKey.currentState.validate())
                                {
                                  await DatabaseService().updatefoodData(
                                    _currentuser,
                                    _currenttitle,
                                    _currentamount,
                                    _currentlocation,  
                                    _currentdescription,
                                    selectedTime.toString(),
                                    selectedDate.toString(),
                                    base64Image); 
                                }
                                Navigator.pop(context);
                                _showDialog();


                                }
                              )

                          ),
                        SizedBox(height: 20.0),
                        backButton,
                        SizedBox(height: 20.0),
                        Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0)),

            ],
          ),
        ),
      ),
        ),
      );

    
  }
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
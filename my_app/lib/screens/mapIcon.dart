import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/screens/foodInfoEdit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class mapIcon extends StatefulWidget
{
  @override
  _mapIcon createState() => _mapIcon();
}

class _mapIcon extends State <mapIcon> 
{
  Completer<GoogleMapController> _controller = Completer();


  @override

  void initState(){
    super.initState();
  }
  double zoomVal = 5.0;

  Set<Marker> foodmarkers = new Set();


  @override
  Widget build(BuildContext context) {

   Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(25.7167234, -80.2737), zoom: zoomVal)));
    }
    Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(25.7167234, -80.2737), zoom: zoomVal)));
    }  

    Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(Icons.zoom_out),
            iconSize: 50,
            onPressed: () {
              zoomVal--;
             _minus( zoomVal);
            }),
    );
    }
    Widget _zoomplusfunction() {
      
        return Align(
          alignment: Alignment.topRight,
          child: IconButton(
                icon: Icon(Icons.zoom_in),
                iconSize: 50,
                onPressed: () {
                  zoomVal++;
                  _plus(zoomVal);
                }),
        );
    }

    Future<void> _gotoLocation(String addr, double lat, double long) async {
        
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
          bearing: 45.0,)));
      }

    User user = Provider.of<User>(context);
    String addr;
    final pics =   
        Align(
        alignment: Alignment.bottomLeft,
                  
        child: Container(
          height: 300,
          child: StreamBuilder(
            stream: Firestore.instance.collection('food').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData) return Text('loading data .... please wait');
              int length = snapshot.data.documents.length;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
                if (snapshot.data.documents[index]['user']!= user.uid)
                  return Container(
                    height: 300,
                  child: Card(
                    color: Colors.grey[300],
                    margin: EdgeInsets.all(15.0),
                    child: Container(
                      height:50,
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                          height: 30,
                          child: 
                            FlatButton(
                              onPressed: (){
                                addr = snapshot.data.documents[index]['address'];
                                double lat = snapshot.data.documents[index]['lat'];
                                double lng = snapshot.data.documents[index]['lng'];
                                String title = snapshot.data.documents[index]['title'];
                                _gotoLocation(addr,lat,lng);
                                
                                Marker foodMarker = Marker(
                                  markerId: MarkerId(title),
                                  position: LatLng(lat, lng),
                                  infoWindow: InfoWindow(title: title),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueGreen,
                                  ),
                                );
                                foodmarkers.add(foodMarker);
                              },
                              splashColor: Colors.blueGrey,
                              child: Text(snapshot.data.documents[index]['title'], style: TextStyle(color:Colors.teal, fontSize: 30)),
                            )
                          ),
                          Image.memory(bytes, height: 200, width: 200)
                        ],
                      )
                    )
                  )
                  );
                  else return Container();
                },
                itemCount: snapshot.data.documents == null ? 0:length,
              );
            }  
            )  
        )
        );


      Widget _buildGoogleMap(BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:  CameraPosition(target: LatLng(25.7167234, -80.2737), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers:foodmarkers
            
          ),
    );
  }


    return Scaffold (
      appBar: AppBar(
            centerTitle: false,
            title: Text("Map View"),
            backgroundColor: Colors.teal,
              actions: <Widget>[
              ]
          ),

      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
        pics
        ],
      )

    );   
  
}

   

  
}



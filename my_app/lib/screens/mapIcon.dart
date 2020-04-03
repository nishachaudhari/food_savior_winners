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

  @override
  Widget build(BuildContext context) {


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
                            _gotoLocation(addr,40.7128,-74.0060);
                          },
                          splashColor: Colors.blueGrey,
                          child: Text(snapshot.data.documents[index]['title'], style: TextStyle(color:Colors.green[600], fontSize: 30)),
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

    return Scaffold (
      appBar: AppBar(
            centerTitle: false,
            title: Text("Map View"),
            backgroundColor: Colors.green,
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
  
}Widget _zoomminusfunction() {

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

 Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }    

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          gramercyMarker,bernardinMarker,blueMarker
        },
      ),
    );
  }

  Future <List <Placemark> >_getLatLngfromAddr (String addr) async{

      List<Placemark> placemark= await Geolocator().placemarkFromAddress(addr);
      return placemark;
      
    }

  Future<void> _gotoLocation(String addr, double lat, double long) async {

  Future <List<Placemark> > placemark =  _getLatLngfromAddr(addr);

    
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueGreen,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueGreen
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueGreen,
  ),
);

 

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;


  ChatModel({this.avatarUrl, this.name, this.datetime, this.message});


  static final List<ChatModel> data = [];

    void intoMarker(title, lat, lng ,markerRef){
        var markerIDVal = markerRef;
        final MarkerId markerId = MarkerId(markerIDVal);
        final Marker marker = Marker(
          position: LatLng(lat, lng),
          markerId: markerId,
          infoWindow: InfoWindow(title: title),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
              )
        );
     //   setState(() {
     //    foodmarkers[markerId] = marker;
    //  });
    }

    populate(){
     Firestore.instance.collection('messages').getDocuments().then((querySnapshot){
       querySnapshot.documents.forEach((result)
          {
            String text = result.data['messages'];
            double lat = result.data['lat'];
            double lng = result.data['lng'];
            String id = result.documentID;
        //    intoMarker(title, lat, lng, id); 
          }
          
        );
        }
     );
    }



  static final List<ChatModel> dummyData = [
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/34.jpg",
      name: "Laurent",
      datetime: "20:18",
      message: "How about meeting tomorrow?",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/49.jpg",
      name: "Tracy",
      datetime: "19:22",
      message: "I love that idea, it's great!",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/women/77.jpg",
      name: "Claire",
      datetime: "14:34",
      message: "I wasn't aware of that. Let me check",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/81.jpg",
      name: "Joe",
      datetime: "11:05",
      message: "Flutter just release 1.0 officially. Should I go for it?",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "Mark",
      datetime: "09:46",
      message: "It totally makes sense to get some extra day-off.",
    ),
    ChatModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/85.jpg",
      name: "Williams",
      datetime: "08:15",
      message: "It has been re-scheduled to next Saturday 7.30pm",
    ),
  ];
}

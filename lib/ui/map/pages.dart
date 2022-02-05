import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hyojason/secret.dart';
import 'package:hyojason/ui/map/map_detail.dart';

class PlacesPage extends StatefulWidget {
  PlacesPage({this.lat, this.lng, this.place});

  final lat, lng, place;

  @override
  _PlacesPageState createState() => _PlacesPageState(
        lat: this.lat,
        lng: this.lng,
        place: this.place,
      );
}

class _PlacesPageState extends State<PlacesPage> {
  _PlacesPageState({this.lat, this.lng, this.place});

  final lat, lng, place;

  static Color mainColor = Color(0xff6524FF);

  late final Set<Marker> markers = new Set();
  late String formatted_address;
  late String formatted_phone_number;
  late String website;

  @override
  void initState() {
    super.initState();
    getNearbyPlaces(lat, lng);

    markers.add(
      Marker(
        markerId: const MarkerId("marker_1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(lat, lng),
        infoWindow: const InfoWindow(
          title: '현재 위치',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(

          flexibleSpace: Container(),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              '근처 $place?',
              style: const TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng),
            zoom: 16,
          ),
          markers: markers,
        ),
      ),
    );
  }

  void getNearbyPlaces(double lat, double lng) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$place&location=$lat,$lng&radius=1500&language=ko&key=$googlekey";

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body)["results"];
      setState(() {
        for (int i = 0; i < data.length; i++) {
          String name= data[i]['name'];
          String placeid= data[i]['place_id'];


          markers.add(
            Marker(
              markerId: MarkerId(data[i]["place_id"]),
              position: LatLng(data[i]["geometry"]["location"]["lat"],
                  data[i]["geometry"]["location"]["lng"]),
              infoWindow: InfoWindow(
                  title: name, snippet: data[i]["vicinity"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlacesdetailPage(
                    lat:data[i]["geometry"]["location"]["lat"],
                    lng:data[i]["geometry"]["location"]["lng"],
                    name:name,
                    placeid:placeid
                  )),
                );
              },
            ),
          );
        }
      });
    } else {
      throw Exception('error occured getting nearby place');
    }
  }

}


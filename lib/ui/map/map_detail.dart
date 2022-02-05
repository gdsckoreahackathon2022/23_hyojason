import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hyojason/secret.dart';


class PlacesdetailPage extends StatefulWidget {
  PlacesdetailPage({this.lat, this.lng, this.name, this.placeid});

  final lat, lng, placeid, name;

  @override
  _PlacesdetailPageState createState() => _PlacesdetailPageState(
        lat: this.lat,
        lng: this.lng,
        name: this.name,
        placeid: this.placeid,
      );
}

class _PlacesdetailPageState extends State<PlacesdetailPage> {
  _PlacesdetailPageState({this.lat, this.lng, this.name, this.placeid});

  final lat, lng, name, placeid;

  static Color mainColor = Color(0xff6524FF);

  late String website;
  late final Set<Marker> markers = new Set();


  @override
  void initState() {
    super.initState();
    markers.add(
      Marker(
        markerId: const MarkerId('marker 2'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: name,
        ),
      ),
    );
    _show(placeid);
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
              '$name 정보',
              style: const TextStyle(fontFamily: 'Noto', fontSize: 30),
            ),
          ),
          elevation: 0.0,
          backgroundColor: mainColor,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 16,
                ),
                markers: markers),
          ),
          FutureBuilder(
              future: _show(placeid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                }
                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '주소',style: TextStyle(
                          fontSize: 30,fontFamily: 'Noto'
                        ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data['formatted_address']??'',
                          style: const TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '연락처',style: TextStyle(
                            fontSize: 30,fontFamily: 'Noto'
                        ),
                        ),
                        Text(
                          snapshot.data['formatted_phone_number']??'',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Future<void> _show(placeid) async {
    final String detailurl =
        "https://maps.googleapis.com/maps/api/place/details/json?key=$googlekey&language=ko&placeid=$placeid";

    var response = await http
        .get(Uri.parse(detailurl), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      final result = json.decode(response.body)["result"];
      return result;
    }
  }
}

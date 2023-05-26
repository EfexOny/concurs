import 'dart:async';

import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class GarbageMap extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<GarbageMap> {
  late List<LatLng> locations;

  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  late Stream<QuerySnapshot> _bikesStream; // New variable for the Firestore stream

  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _followCurrentLocationStreamController = StreamController<double?>();
    _bikesStream = FirebaseFirestore.instance.collection('garbage').snapshots(); // Initialize the Firestore stream
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "MAP",
        leading: "back",
        action: true,
        onPressed: () {},
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bikesStream, // Use the initialized Firestore stream
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data found');
          }

          List<LatLng> locations = snapshot.data!.docs.map((doc) {
            return LatLng(
              doc['latitude'].toDouble(),
              doc['longitude'].toDouble(),
            );
          }).toList();

          List<Marker> markers = locations.map((LatLng latLng) {
            return Marker(
              point: latLng,
              builder: (BuildContext context) => Image.asset(ImageConstant.location),
            );
          }).toList();

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(46, 25),
                  zoom: 9.2,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: markers),
                  CurrentLocationLayer(
                    followCurrentLocationStream: _followCurrentLocationStreamController.stream,
                    followOnLocationUpdate: _followOnLocationUpdate,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    heroTag: 'recenterr',
                    onPressed: () {
                      setState(() => _followOnLocationUpdate = FollowOnLocationUpdate.once);
                      _followCurrentLocationStreamController.add(18);
                    },
                    child: Icon(
                      Icons.my_location,
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xFFECEDF1)),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FirestoreStreamWidget extends StatelessWidget {
  final Stream<QuerySnapshot> stream;
  final Widget Function(BuildContext, AsyncSnapshot<QuerySnapshot>) builder;

  FirestoreStreamWidget({required this.stream, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: builder,
    );
  }
}

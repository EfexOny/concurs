import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class AdminPage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController cityController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  Future<bool> isAdmin() async {
    if (user != null) {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get();

      if (userSnapshot.size > 0) {
        DocumentSnapshot userDoc = userSnapshot.docs.first;
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          int adminValue = userData['admin'] ?? 0;
          return adminValue == 1;
        }
      }
    }
    return false;
  }

  Future<int> getNewBikeId() async {
    QuerySnapshot bikesSnapshot = await FirebaseFirestore.instance
        .collection('bikes')
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    if (bikesSnapshot.size > 0) {
      DocumentSnapshot lastBikeDoc = bikesSnapshot.docs.first;
      Map<String, dynamic>? lastBikeData =
          lastBikeDoc.data() as Map<String, dynamic>?;

      if (lastBikeData != null) {
        int lastId = lastBikeData['id'] ?? 0;
        return lastId + 1;
      }
    }

    return 1; // If no bikes exist, start with ID 1
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Location permissions are denied (actual value: $permission).';
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> addNewBike(String city, String type) async {
    int newId = await getNewBikeId();
    Position currentPosition = await getCurrentLocation();
    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;

    Map<String, dynamic> bikeData = {
      'id': newId,
      'available': 1,
      'city': city,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    };

    await FirebaseFirestore.instance.collection('bikes').add(bikeData);
  }

  Future<void> addNewGarbagePoint() async {
    Position currentPosition = await getCurrentLocation();
    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;

    Map<String, dynamic> garbageData = {
      'latitude': latitude,
      'longitude': longitude,
    };

    await FirebaseFirestore.instance
        .collection('garbage')
        .add(garbageData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAdmin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool isAdmin = snapshot.data!;
          if (isAdmin) {
            return Scaffold(
              appBar: appBar(
        text: "Admin",
        leading: "back",
        action: true,
        onPressed: () {},
      ),
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Bike',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: typeController,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        String type = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),

                      onPressed: () async {
                        String city = cityController.text; // Replace with the stored city value
                        String type = typeController.text; // Replace with the stored type value

                        await addNewBike(city, type);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New bike added successfully!'),
                          ),
                        );
                      },
                      child: Text('Add New Bike'),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Add New Garbage Point',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        await addNewGarbagePoint();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('New garbage point added successfully!'),
                          ),
                        );
                      },
                      child: Text('Add New Garbage Point'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // User is not an admin, show a different page or handle accordingly
            return Scaffold(
              appBar: appBar(
        text: "Admin",
        leading: "back",
        action: true,
        onPressed: () {},
              ),
              body: Center(
                child: Text(
                  'You are not authorized to access this page.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
        }
        // Loading state while checking admin status
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

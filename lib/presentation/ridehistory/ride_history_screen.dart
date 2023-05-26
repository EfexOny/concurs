import 'package:BikeX/core/app_export.dart';
import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/ridehistory/data.dart';
import 'package:BikeX/presentation/ridehistory/datafrom.dart';
import 'package:BikeX/presentation/ridehistory/datato.dart';
import 'package:BikeX/presentation/ridehistory/distance.dart';
import 'package:BikeX/presentation/ridehistory/readbike_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class RideHistoryScreen extends StatefulWidget {
  RideHistoryScreen({Key? key}) : super(key: key);

  @override
  _RideHistoryScreenState createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  final user = FirebaseAuth.instance.currentUser;

  List<String> ridesIDs = [];
  List<Map<String, dynamic>> ridesData = [];
  List<String> bamIds = [];
  List<String> finalIDs = [];
  String Id = "";

 Future<void> getRideId() async {
  ridesIDs.clear(); // Clear the ridesIDs list
  ridesData.clear(); // Clear the ridesData list

  await FirebaseFirestore.instance
      .collection('users')
      .where("email", isEqualTo: user!.email!)
      .get()
      .then((value) => value.docs.forEach((element) {
            Id = element.reference.id;
          }));

  await FirebaseFirestore.instance
      .collection("users")
      .doc(Id)
      .collection('rides')
      .get()
      .then((value) => value.docs.forEach((element) {
            ridesIDs.add(element.reference.id);
            ridesData.add({}); // Add an empty map to ridesData
          }));
}


  Future<bool> checkRentalStatus(String rideId) async {
    DocumentSnapshot rideSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .collection('rides')
        .doc(rideId)
        .get();

    Map<String, dynamic>? rideData =
        rideSnapshot.data() as Map<String, dynamic>?;

    if (rideData != null) {
      String status = rideData['status'];
      return status == '?';
    }

    return false;
  }

  Future<Map<String, dynamic>?> updateRideData(String rideId) async {
    Position position = await Geolocator.getCurrentPosition();
    final location = [position.latitude, position.longitude];

    DocumentSnapshot rideSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(Id)
        .collection('rides')
        .doc(rideId)
        .get();
    Map<String, dynamic>? rideData =
        rideSnapshot.data() as Map<String, dynamic>?;

    if (rideData != null) {
      List<dynamic>? fromCoordinates = rideData['from'];
      List<double>? toCoordinates = location;

      if (fromCoordinates != null && toCoordinates != null) {
        List<double> fromCoordinatesTyped = fromCoordinates.cast<double>();

        double distance = await Geolocator.distanceBetween(
          fromCoordinatesTyped[0],
          fromCoordinatesTyped[1],
          toCoordinates[0],
          toCoordinates[1],
        );

        double distanceInKm = distance / 1000;
        String formattedDistance = distanceInKm.toStringAsFixed(2);
        double price = distanceInKm * 0.5;
        String priceformatted = price.toStringAsFixed(2);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(Id)
            .collection('rides')
            .doc(rideId)
            .update({
          'to': location,
          'status': FieldValue.delete(),
          'distance': double.parse(formattedDistance),
          'price': priceformatted,
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(Id)
            .update({'points': FieldValue.increment(1)});

        // Search for the bike with the same ID in the bikes collection
        QuerySnapshot bikeSnapshot = await FirebaseFirestore.instance
            .collection('bikes')
            .where('id', isEqualTo: rideData['id'])
            .get();

        if (bikeSnapshot.docs.isNotEmpty) {
          DocumentSnapshot bikeDoc = bikeSnapshot.docs.first;
          Map<String, dynamic>? bikeData =
              bikeDoc.data() as Map<String, dynamic>?;

          if (bikeData != null) {
            await bikeDoc.reference.update({'available': 1});
          }
        }

        return {
          'to': location,
          'status': null, // or any other value you want to indicate the ride is not rented
          'distance': double.parse(formattedDistance),
          'price': priceformatted,
        };
      }
    }

    return null;
  }

  Future<void> confirmUnrent(BuildContext context, String rideId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unrent Confirmation'),
          content: const Text('Are you sure you want to unrent this bike?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the confirmation dialog

                Map<String, dynamic>? updatedRide =
                    await updateRideData(rideId);
                if (updatedRide != null) {
                  setState(() {
                    int rideIndex = ridesIDs.indexOf(rideId);
                    ridesData[rideIndex] = updatedRide;
                  });
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "Ride History",
        leading: "back",
        action: true,
        onPressed: () {},
      ),
      body: FutureBuilder(
        future: getRideId(),
        builder: (context, snapshot) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: ridesIDs.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    height: constraints.maxHeight / 4.5,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.containerBorderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GetBikeName(
                                      documentId: ridesIDs[i], documentId2: Id),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.subTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          GetFrom(
                                              documentId: ridesIDs[i],
                                              documentId2: Id),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "To",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.subTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          GeTo(
                                              documentId: ridesIDs[i],
                                              documentId2: Id),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    GetDistance(
                                        documentId: ridesIDs[i],
                                        documentId2: Id),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GetPrice(
                                        documentId: ridesIDs[i],
                                        documentId2: Id),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              FutureBuilder<bool>(
                                future: checkRentalStatus(ridesIDs[i]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    bool isRented = snapshot.data!;
                                    if (isRented) {
                                      return Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            confirmUnrent(
                                                context, ridesIDs[i]);
                                          },
                                          child: Text('Unrent'),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }
                                  return SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

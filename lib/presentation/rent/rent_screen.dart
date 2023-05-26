import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/rent/city.dart';
import 'package:BikeX/presentation/rent/read_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class RentScreen extends StatefulWidget {
  RentScreen({Key? key}) : super(key: key);

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  final CollectionReference bikeCollection =
      FirebaseFirestore.instance.collection('bikes');
  late List<String> bikeIDs;
  bool isRenting = false; // Track user's rental status

  @override
  void initState() {
    super.initState();
    bikeIDs = [];
    getRentId();
    checkRentalStatus();
  }

  Future<void> getRentId() async {
    final snapshot = await bikeCollection.get();
    snapshot.docs.forEach((element) {
      bikeIDs.add(element.id);
    });
    setState(() {});
  }

  Future<void> checkRentalStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userRef = userSnapshot.docs.first.reference;
        final ridesSnapshot = await userRef
            .collection('rides')
            .where('status', isEqualTo: '?')
            .get();

        setState(() {
          isRenting = ridesSnapshot.docs.isNotEmpty;
        });
      }
    }
  }

  Future<void> handleRentButtonPress(BuildContext context, int index) async {
    // Check if the user is already renting a bike
    if (isRenting) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Rent Notification'),
            content: const Text('You already have an active rental.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final docRef = bikeCollection.doc(bikeIDs[index]);
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('available')) {
      if (data['available'] == 1) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: user.email)
              .limit(1)
              .get();

          if (userSnapshot.docs.isNotEmpty) {
            final userRef = userSnapshot.docs.first.reference;
            final ridesCollection = userRef.collection('rides');

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Rent Confirmation'),
                  content:
                      const Text('Are you sure you want to rent this bike?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(); // Close the confirmation dialog

                        // Update bike availability
                        await docRef.update({'available': 0});

                        final position = await Geolocator.getCurrentPosition();
                        final location = [position.latitude, position.longitude];
                        final bikeType = data['type'];

                        // Add ride details to user's collection
                        await ridesCollection.add({
                          'from': location,
                          'type': bikeType,
                          'to': 'Still rented',
                          'distance': '?',
                          'status': '?',
                          'id': docSnapshot['id'],
                        });

                        // Update rental status
                        setState(() {
                          isRenting = true;
                        });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Ride Confirmation'),
                              content: const Text('Ride booked successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the inner dialog
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(); // Close the outer dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('OK'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Rent Notification'),
              content:
                  const Text('This bike is currently unavailable for rent.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent'),
      ),
      body: ListView.builder(
        itemCount: bikeIDs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Bike ${index + 1}'),
            trailing: ElevatedButton(
              onPressed: () => handleRentButtonPress(context, index),
              child: const Text('Rent'),
            ),
          );
        },
      ),
    );
  }
}

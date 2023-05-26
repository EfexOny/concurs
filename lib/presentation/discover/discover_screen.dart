import 'package:BikeX/presentation/commonWidgets/app_bar.dart';
import 'package:BikeX/presentation/rent/city.dart';
import 'package:BikeX/presentation/rent/read_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({Key? key}) : super(key: key);

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<DiscoverScreen> {
  final CollectionReference bikeCollection =
      FirebaseFirestore.instance.collection('bikes');
  late List<String> bikeIDs;

  @override
  void initState() {
    super.initState();
    bikeIDs = [];
    getRentId();
  }

  Future<void> getRentId() async {
    final snapshot = await bikeCollection.get();
    snapshot.docs.forEach((element) {
      bikeIDs.add(element.id);
    });
    setState(() {});
  }

  Future<void> handleRentButtonPress(BuildContext context, int index) async {
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
            final userDocRef = userSnapshot.docs.first.reference;
            final ridesCollection = userDocRef.collection('rides');
            final ridesSnapshot =
                await ridesCollection.where('status', isEqualTo: 'Still rented').get();

            if (ridesSnapshot.docs.isNotEmpty) {
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

            showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Rent Notification'),
      content: const Text('You have rented this bike!'),
      actions: [
        TextButton(
          onPressed: () async {
            await docRef.update({'available': 0});
            final position = await Geolocator.getCurrentPosition();
            final location = [position.latitude, position.longitude];
            final bikeType = data['type'];
            final newRideDoc = await ridesCollection.add({
              'from': location,
              'type': bikeType,
              "to": "Still rented",
              "distance": "?",
              'status': '?',
              'id': docSnapshot["id"],
            });

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Ride Confirmation'),
                  content: Text('Ride ID: ${newRideDoc.id}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the inner dialog
                        Navigator.of(context, rootNavigator: true).pop(); // Close the outer dialog
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
              content: const Text('This bike is currently unavailable for rent.'),
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
      body: ListView.builder(
        itemCount: bikeIDs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: GetUserName(documentId: bikeIDs[index]),
            subtitle: GetCity(documentId: bikeIDs[index]),
            trailing: ElevatedButton(
              onPressed: () => handleRentButtonPress(context, index),
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text('Rent'),
            ),
          );
        },
      ),
    );
  }
}


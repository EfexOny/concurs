import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetRides extends StatelessWidget {
  final String documentId;

  const GetRides({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference rides = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: rides.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Bike: ${data['rides']}");
        }
        return Text("loading..");
      }),
    );
  }
}

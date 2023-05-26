import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetCity extends StatelessWidget {
  final String documentId;

  const GetCity({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference bikes = FirebaseFirestore.instance.collection('bikes');

    return FutureBuilder<DocumentSnapshot>(
      future: bikes.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['city']}");
        }
        return Text("loading..");
      }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GeTo extends StatelessWidget {
  final String documentId,documentId2;

  const GeTo({required this.documentId,required this.documentId2});



  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;

    CollectionReference bikes =
        FirebaseFirestore.instance.collection('users').doc(documentId2).collection('rides');

    return FutureBuilder<DocumentSnapshot>(
      future: bikes.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['to']}");
        }
        return Text("loading..");
      }),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> userSetup(String username, String email) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String userid = auth.currentUser!.uid.toString();
  String email = auth.currentUser!.email.toString();
  users.add({'email': email, 'username': username, 'userid': userid});
}

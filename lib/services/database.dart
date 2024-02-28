import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mywallet/utils/show_progress.dart';

class Database {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data, context) async {

    final userId = FirebaseAuth.instance.currentUser!.uid;

    await users
        .doc(userId)
        .set(data)
        .then((value) => print('New user added'))
        .catchError((error) {
          Fluttertoast.showToast(msg: 'Something went wrong');
          print(error);
    });

  }

  Future<void> updateUser(data, context) async {

    final userId = FirebaseAuth.instance.currentUser!.uid;

    await users
        .doc(userId)
        .update(data)
        .then((value) => print('New update'))
        .catchError((error) {
          Fluttertoast.showToast(msg: 'Something went wrong');
          print(error);
    });


  }

}
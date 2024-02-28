import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mywallet/utils/upload_image.dart';

void uploadLoanerImage(String id) async {
  Uint8List img = await pickImage();
  String order = DateTime.now().millisecondsSinceEpoch.toString();

  //ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
  //progressDialog.show();
  //upload to Firebase storage
  Reference reference = FirebaseStorage.instance.ref().child(order);
  UploadTask task = reference.putData(img);
  TaskSnapshot snapshot = await task;
  String avatar = await snapshot.ref.getDownloadURL();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('loaners')
      .doc(id).update({
    'avatar' : avatar,
    'fileId' : order,
  });
  //progressDialog.dismiss();
}

Future<void> setLoanerDefault(String id) async {

  var fileId = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('loaners').doc(id).get();

  await FirebaseStorage.instance.ref().child(fileId['fileId']).delete();


  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('loaners').doc(id).update({
    'avatar' : 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png',
    'fileId' : '',
  });
}
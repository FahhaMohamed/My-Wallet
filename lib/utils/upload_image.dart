import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';


pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

  final ImageCropper imageCropper = ImageCropper();
  final CroppedFile? croppedFile = await imageCropper.cropImage(
      sourcePath: xFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  );

  XFile? file = XFile(croppedFile!.path);

  if(file != null){
    return await file.readAsBytes();
  }
  else{
    print("No Image selected");
  }
}

void uploadImage(BuildContext context) async {
  Uint8List img = await pickImage();

  SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

  dialog.show(
    message: 'Uploading....',
    type: SimpleFontelicoProgressDialogType.hurricane,
    backgroundColor: Colors.transparent,
    indicatorColor: const Color(0xffc43990),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(.6),
    ),
  );

  String order = DateTime.now().millisecondsSinceEpoch.toString();

  //ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
  //progressDialog.show();
  //upload to Firebase storage
  Reference reference = FirebaseStorage.instance.ref().child(order);
  UploadTask task = reference.putData(img);
  TaskSnapshot snapshot = await task;
  String avatar = await snapshot.ref.getDownloadURL();

  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
    'avatar' : avatar,
    'File id' : order,
  });

  dialog.hide();
  //progressDialog.dismiss();
}

Future<void> setDefault(BuildContext context) async {

  SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

  dialog.show(
    message: 'Uploading....',
    type: SimpleFontelicoProgressDialogType.hurricane,
    backgroundColor: Colors.transparent,
    indicatorColor: const Color(0xffc43990),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(.6),
    ),
  );

  var id = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

  await FirebaseStorage.instance.ref().child(id['File id']).delete();


  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
    'avatar' : 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png',
    'File id' : '',
  });

  dialog.hide();

}

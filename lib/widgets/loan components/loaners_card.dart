import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mywallet/controller/imageController.dart';
import 'package:mywallet/widgets/loan%20components/cached_loaner_pic.dart';
import 'package:mywallet/widgets/loan%20components/view_loaner.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../constant/colors.dart';
import '../../utils/upload_image.dart';
import '../auth components/component1.dart';

Widget LoanersCard(BuildContext context,{required data, required String currency}) {


   Map<String, dynamic> newData = {
    'name' : data['name'],
    'avatar' : data['avatar'],
    'id' : data['id'],
    'type' : data['type'],
    'fileId' : data['fileId'],
    'phone' : data['phone'],
    'totalDebit' : data['totalDebit'],
    'totalCredit' : data['totalCredit'],
    'collect' : data['collect'],
    'currency' : currency,
  };

   TextEditingController nameEditingController = TextEditingController(text: newData['name']);
   TextEditingController phoneEditingController = TextEditingController(text: newData['phone']);

  return Consumer<ImageController>(
    builder: (BuildContext context, value, Widget? child) {



      return ZoomTapAnimation(


        onLongTap: (){

          value.update(newData['avatar']);

          showCupertinoDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  content: Container(
                    height: 400,
                    child: Column(
                      children: [

                        const SizedBox(height: 30,),


                        Consumer<ImageController>(
                        builder: (BuildContext context, value2, Widget? child) {
                          return Center(child: LoanerPic(context, avatar: value2.avatar, size: 80));
                        } ),



                        const SizedBox(height: 10,),

                        ZoomTapAnimation(
                            onTap: () async {

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

                              String order = newData['fileId'] == '' ? DateTime.now().millisecondsSinceEpoch.toString() : newData['fileId'];

                              //ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
                              //progressDialog.show();
                              //upload to Firebase storage
                              Reference reference = FirebaseStorage.instance.ref().child(order);
                              UploadTask task = reference.putData(img);
                              TaskSnapshot snapshot = await task;
                              String avatar = await snapshot.ref.getDownloadURL();

                              dialog.hide();

                              value.update(avatar);

                              newData.update('avatar', (value) => avatar);

                              //Navigator.pop(context);

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('loaners')
                                  .doc(newData['id']).update({
                                'avatar' : avatar,
                                'fileId' : order,
                              });



                              Fluttertoast.showToast(msg: 'Profile updated',backgroundColor: Colors.white,textColor: Colors.black);
                            },
                            child: Text('Change picture',style: TextStyle(color: CustomColor.purple[0],fontSize: 16),)),

                        const SizedBox(height: 3,),

                        ZoomTapAnimation(
                            onTap: () async {

                              value.update('http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png');

                              newData.update('avatar', (value) => 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png');

                              //Navigator.pop(context);

                              var fileId = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('loaners').doc(newData['id']).get();

                              await FirebaseStorage.instance.ref().child(fileId['fileId']).delete();


                              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('loaners').doc(newData['id']).update({
                                'avatar' : 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png',
                                'fileId' : '',
                              });


                              Fluttertoast.showToast(msg: 'Profile Set Default',backgroundColor: Colors.white,textColor: Colors.black);

                            },
                            child: Text('Set default',style: TextStyle(color: CustomColor.purple[1],fontSize: 16),)),

                        const SizedBox(height: 10,),

                        Component1(context, Text(''), controller: nameEditingController, icon: Icons.person, hintText: 'Rename'),
                        Component1(context, Text(''), controller: phoneEditingController, icon: Icons.phone, hintText: 'Phone',isAmount: true ,isPhone: true),

                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    ElevatedButton(
                      onPressed: (){Navigator.pop(context);},
                      child: Text('NO'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(.3),
                          foregroundColor: Colors.black
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () async {

                        if(nameEditingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please, Enter the name');
                        } else if(phoneEditingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please, Enter the Whatsapp no');
                        }else{

                          newData.update('name', (value) => nameEditingController.text.capitalize);
                          newData.update('phone', (value) => phoneEditingController.text.trim());

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('loaners').doc(newData['id']).update({
                            'name' : newData['name'],
                            'phone' : newData['phone'],
                          });

                          Fluttertoast.showToast(msg: 'Updated.');
                          Navigator.pop(context);

                        }

                      },
                      child: Text('EDIT'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(.6),
                          foregroundColor: Colors.black
                      ),
                    ),
                  ],

                );
              }
          );

        },

        onTap: () async {

          if(newData['type'] == 'Debtor') {

            if(newData['totalDebit'] == 0.0) {

              SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

              dialog.show(
                message: 'Opening....',
                type: SimpleFontelicoProgressDialogType.hurricane,
                backgroundColor: Colors.transparent,
                indicatorColor: const Color(0xffc43990),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(.6),
                ),
              );

              final documents = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('loaners').doc('${newData['id']}').collection('items').get();

              for (var document in documents.docs) {
                await document.reference.delete();
              }

              dialog.hide();
            }

          }else {

            if(newData['totalCredit'] == 0.0) {

              SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

              dialog.show(
                message: 'Opening....',
                type: SimpleFontelicoProgressDialogType.hurricane,
                backgroundColor: Colors.transparent,
                indicatorColor: const Color(0xffc43990),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(.6),
                ),
              );

              final documents = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('loaners').doc('${newData['id']}').collection('items').get();

              for (var document in documents.docs) {
                await document.reference.delete();
              }

              dialog.hide();

            }

          }

          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context)=> ViewLoaner(
                model: newData,
              ),
            ),
          );
        },

        child: Dismissible(
          background: Container(margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 20,left: 10),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(.6),
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3))
                ]),
            alignment: Alignment.centerRight,
            child: Icon(CupertinoIcons.delete,color: Colors.black,),
          ),
          direction: DismissDirection.endToStart,
          key: ValueKey(data),
          onDismissed: (DismissDirection direction) async {
            if(data['type'] == 'Creditor' && data['totalCredit'] != 0.0){
              ToastService.showWarningToast(context,message: "Can't Remove ${data['name']}");
            } else if(data['type'] == 'Debtor' && data['totalDebit'] != 0.0){
              ToastService.showWarningToast(context,message: "Can't Remove ${data['name']}");
            } else {
              SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

              dialog.show(
                message: 'Deleting....',
                type: SimpleFontelicoProgressDialogType.hurricane,
                backgroundColor: Colors.transparent,
                indicatorColor: const Color(0xffc43990),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(.6),
                ),
              );

              if(data['fileId'] != '') {
                await FirebaseStorage.instance.ref().child('${data['fileId']}').delete();
              }

              final documents = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('loaners').doc('${data['id']}').collection('items').get();

              for (var document in documents.docs) {

                await document.reference.delete();

              }

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('loaners').doc('${data['id']}').delete();


              dialog.hide();
            }
          },

          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 20,left: 10),
            decoration: BoxDecoration(
                color: CustomColor.purple[2].withOpacity(.5),
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3))
                ]),
            child: Row(
              children: [
                LoanerPic(context, avatar: newData['avatar'], size: 50),
                const SizedBox(width: 10,),
                Text(
                  newData['name'],
                  style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontSize: 16
                  ),
                ),
                const Spacer(),
                if(data['type'] == 'Creditor')
                  Text(
                    '${newData['totalCredit']} ${newData['currency']}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 16
                    ),
                  ),
                if(data['type'] == 'Debtor')
                  Text(
                    '${newData['totalDebit']} ${newData['currency']}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 16
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );

}
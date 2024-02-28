import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mywallet/constant/loaners.dart';
import 'package:mywallet/services/database.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';
import 'package:mywallet/widgets/loan%20components/cached_loaner_pic.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../constant/colors.dart';
import '../../utils/upload_image.dart';

class AddNewLoaner extends StatefulWidget {

  final String title;

  AddNewLoaner({super.key, required this.title});

  @override
  State<AddNewLoaner> createState() => _AddNewLoanerState();
}

class _AddNewLoanerState extends State<AddNewLoaner> {

  TextEditingController nameEditingController = TextEditingController();

  TextEditingController phoneEditingController = TextEditingController(text: '+94');


  String nameError = '';

  String phoneError = '';


  String avatar = 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';

  String fileId = '';

  Future<List<String>> setImage() async {

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
    dialog.hide();

    return [avatar, order];


    //progressDialog.dismiss();
  }

  var db = Database();

  var loan = Loaners();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: CustomColor.purple[3].withOpacity(0.3),
          title: Text('Add new ${widget.title}',
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 17
            ),
          ),
          leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.close,color: Colors.white.withOpacity(.6),size: 30,),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 40.0,),

                Center(
                  child: Column(
                    children: [

                      LoanerPic(context, avatar: avatar, size: 80),

                      const SizedBox(height: 10,),

                      ZoomTapAnimation(
                          onTap: () async {

                            List item = await setImage();

                            setState(() {

                              avatar = item[0];
                              fileId = item[1];
                            });
                          },
                          child: Text('Add picture',style: TextStyle(color: CustomColor.purple[0],fontSize: 16),)),

                      const SizedBox(height: 3,),

                      ZoomTapAnimation(
                          onTap: (){
                            setState(() {
                              avatar = 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';
                              fileId = '';
                            });
                          },
                          child: Text('Set default',style: TextStyle(color: CustomColor.purple[1],fontSize: 16),)),

                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                Component1(context, Text(''), controller: nameEditingController, icon: Icons.person_outline, hintText: '${widget.title} name', error: nameError),



                const SizedBox(height: 20,),

                Text('Add Whatsapp number with Country code',
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 14
                  ),
                ),

                Component1(context, Text(''), controller: phoneEditingController, icon: CupertinoIcons.phone, hintText: 'Mobile with Country code', isAmount: true, isPhone: true, error: phoneError),

                const SizedBox(height: 10,),



                Component2(
                    context,
                    onTap: () async {

                      String phone = phoneEditingController.text.trim();
                      String? name = nameEditingController.text.capitalize;

                      if(name!.isEmpty) {
                        setState(() {
                          nameError = 'Please enter your Debtor name';
                        });
                      }

                      if(name.isNotEmpty) {
                        setState(() {
                          nameError = '';
                        });
                      }

                      if(phoneError == '' && nameError == '') {

                        SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

                        dialog.show(
                          message: 'Adding....',
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

                        var data = {
                          'name' : name,
                          'phone' : phone,
                          'avatar' : avatar,
                          'fileId' : fileId,
                          'type' : widget.title,
                          'totalCredit': 0.0,
                          'totalDebit' : 0.0,
                          'collect' : 0.0,
                          'id' : order,
                          'order' : DateTime.now(),
                        };

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('loaners').doc(order).set(data);

                        dialog.hide();

                        Navigator.pop(context);
                      }


                    },
                    title: 'Add ${widget.title}'),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

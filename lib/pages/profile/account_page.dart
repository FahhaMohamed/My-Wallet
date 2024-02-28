import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mywallet/utils/upload_image.dart';
import 'package:mywallet/widgets/my%20profile%20component/editForm.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../constant/colors.dart';
import '../../widgets/decoration_components/cached _image.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String username = 'Username';
  String email = '';
  String avatar = 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';
  String remainingAmount = '';
  String targetAmount = '';
  String budgetAmount = '';
  String currency = '';

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((data) {
      setState(() {
        username = data['username'];
        avatar = data['avatar'];
        remainingAmount = data['remainingAmount'].toString();
        targetAmount = data['targetAmount'].toString();
        budgetAmount = data['budgetAmount'].toString();
        currency = data['currency'];
      });
    });

    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        title: Text('Edit Account',
          style: GoogleFonts.aBeeZee(
              color: Colors.white.withOpacity(.7),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios,color: Colors.white.withOpacity(.7),size: 24,),
        ),
      ),
      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20.0,),

              Center(
                child: Column(
                  children: [
                    ZoomTapAnimation(
                      onTap: (){

                        showDialog(barrierDismissible: true,context: context, builder: (context) {

                          return Dialog(
                            child: CachedImage(userId: FirebaseAuth.instance.currentUser!.uid),
                          );

                        });

                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.7),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: ClipOval(
                          child: CachedImage(userId: FirebaseAuth.instance.currentUser!.uid),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10,),

                    ZoomTapAnimation(
                        onTap: (){
                          uploadImage(context);
                        },
                        child: Text('Change picture',style: TextStyle(color: CustomColor.purple[0],fontSize: 16),)),

                    const SizedBox(height: 3,),

                    ZoomTapAnimation(
                        onTap: (){
                          setDefault(context);
                        },
                        child: Text('Set default',style: TextStyle(color: CustomColor.purple[1],fontSize: 16),)),

                  ],
                ),
              ),

              EditForm(context, title: 'Username', formTitle: username,isAmount: false),

              EditForm(context, title: 'Wallet Balance', formTitle: remainingAmount, currency: currency),

              EditForm(context, title: 'This Month Target', formTitle: targetAmount, currency: currency),

              EditForm(context, title: 'This Month Budget', formTitle: budgetAmount, currency: currency),

            ],
          ),
        ),
      ),
    );
  }
}

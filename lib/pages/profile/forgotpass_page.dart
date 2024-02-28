import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/utils/reset_password.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toasty_box/toast_service.dart';

import '../../constant/colors.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {

  TextEditingController emailEditingController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: CustomColor.purple[3].withOpacity(0.3),
          title: Text('Change password',
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
              children: [

                const SizedBox(height: 40,),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text('Enter your Email address and we will send you a password reset link',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontSize: 17,

                    ),
                  ),
                ),

                Component1(
                    context,
                    const Text(''),
                    controller: emailEditingController,
                    icon: CupertinoIcons.mail_solid,
                    hintText: 'Email address',
                    error: error,
                ),

                const SizedBox(height: 10,),

                Component2(
                    context,
                    onTap: () async {

                      var user = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();


                      if(emailEditingController.text.trim().isEmpty) {
                        setState(() {
                          error = 'Please enter your Email address';
                        });
                      }
                      if(emailEditingController.text.trim().isNotEmpty) {

                        setState(() {
                          error = '';
                        });

                      }

                      if(emailEditingController.text.trim() != user['email']) {
                        setState(() {
                          error = 'Invalid Email address';
                        });
                      }
                      if(emailEditingController.text.trim() == user['email']) {

                        setState(() {
                          error = '';
                        });

                        passwordReset(context, emailEditingController.text.trim());

                      }


                    },
                    title: 'Reset password',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

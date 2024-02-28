import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toasty_box/toast_service.dart';

Future passwordReset(BuildContext context,String email) async {
  try{

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ToastService.showToast(
        context,
        message: 'Sending the link.....',
        messageStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        backgroundColor: Colors.white.withOpacity(.7),
        shadowColor: Colors.black,
        leading: const Icon(Iconsax.message,color: Colors.black,size: 30,)
    );

  } on FirebaseAuthException catch(e) {

    ToastService.showErrorToast(context,message: '${e.message}');

  } catch(e) {

    print('Firebase: $e');

  }
}
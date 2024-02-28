import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mywallet/services/database.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toasty_box/toast_service.dart';

import '../pages/main_page.dart';
import '../pages/start up pages/balance_add_page.dart';
import '../utils/snackBar_content.dart';

class AuthService {

  var database = Database();

  createUser(data,String password, BuildContext context) async {

    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

    dialog.show(
      message: 'Creating....',
      type: SimpleFontelicoProgressDialogType.hurricane,
      backgroundColor: Colors.transparent,
      indicatorColor: const Color(0xffc43990),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(.6),
      ),
    );

    try{

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: password,
      );

      if(userCredential.user != null) {

        await database.addUser(data, context);

        dialog.hide();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const BalanceAddPage()));

      } else {

        dialog.hide();
        Fluttertoast.showToast(msg: 'Failed',backgroundColor: Colors.black,textColor: Colors.white);
      }


    } on FirebaseAuthException catch(e) {

      dialog.hide();

      if(e.code == 'email-already-in-use'){


        Fluttertoast.showToast(msg: 'Email is already in Use',backgroundColor: Colors.black,textColor: Colors.white);

      }else if(e.code == 'weak-password'){


        Fluttertoast.showToast(msg: 'Password is weak',backgroundColor: Colors.black,textColor: Colors.white);

      }else if(e.code == 'invalid-credential'){

        Fluttertoast.showToast(msg: 'Invalid email or password',);

      } else if(e.code=='invalid-email'){

        Fluttertoast.showToast(msg: 'Invalid email address',);

      }else if(e.code=='network-request-failed'){

        Fluttertoast.showToast(msg: 'Please check your network connection.',);

      }else{

        print('Error is : ' + e.code);
        Fluttertoast.showToast(msg: 'Something went wrong',backgroundColor: Colors.black,textColor: Colors.white);

      }

    } catch (e) {

      dialog.hide();

      print('catch error is' + e.toString());
      Fluttertoast.showToast(msg: 'Something went wrong',backgroundColor: Colors.black,textColor: Colors.white);

    }


  }

  loginUser(data, BuildContext context) async {

    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

    dialog.show(
      message: 'Logging In....',
      type: SimpleFontelicoProgressDialogType.hurricane,
      backgroundColor: Colors.transparent,
      indicatorColor: const Color(0xffc43990),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(.6),
      ),
    );

    try{

      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential usercredential = await auth.signInWithEmailAndPassword(
          email: data['email'],
          password: data['password'],
      );

      if(usercredential.user!=null){

        dialog.hide();

        ToastService.showSuccessToast(context,message: 'You are logged in successfully.');
        Get.off(()=>const MainPage(),);

      }

    }
    on FirebaseAuthException catch(e){

      dialog.hide();

      if(e.code=='user-not-found'){

        Fluttertoast.showToast(msg: 'User not found',);

      }else if(e.code=='wrong-password'){

        Fluttertoast.showToast(msg: 'Wrong password',);

      } else if(e.code == 'invalid-credential'){

        Fluttertoast.showToast(msg: 'Incorrect email or password',);

      } else if(e.code=='invalid-email'){

        Fluttertoast.showToast(msg: 'Invalid email address',);

      } else if(e.code=='network-request-failed'){

        Fluttertoast.showToast(msg: 'Please check your network connection.',);

      } else {

        print(e.code);
        Fluttertoast.showToast(msg: '${e.code.capitalize}',);

      }

    }
    catch(e){

      dialog.hide();
      Fluttertoast.showToast(msg: 'Something went wrong',);

    }

  }

}
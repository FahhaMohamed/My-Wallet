import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constant/colors.dart';

class ShowEditor extends StatelessWidget {

  final String title;
  final String formTitle;
  final bool isAmount;
  final String currency;

  ShowEditor({super.key, required this.title, required this.formTitle , required this.isAmount, required this.currency,});

  TextEditingController textEditingController = TextEditingController();

  String? name = '';
  double value = 0.0;

  @override
  Widget build(BuildContext context) {

    textEditingController.text = formTitle;

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        appBar: AppBar(
          backgroundColor: CustomColor.purple[3].withOpacity(0.3),
          title: Text('Edit $title',
            style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 18
            ),
          ),
          leading: IconButton(
            onPressed: (){Get.back();},
            icon: Icon(Icons.close,color: Colors.white.withOpacity(.6),size: 30,),
          ),
          actions: [
            IconButton(
              onPressed: (){

                if(textEditingController.text.isNotEmpty) {
                  if(isAmount) {
                    value = double.parse(textEditingController.text.trim());

                    if(title == 'Wallet Balance') {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'remainingAmount' : value,
                      });
                      Get.back();
                    }

                    if(title == 'This Month Target') {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'targetAmount' : value,
                      });
                      Get.back();
                    }

                    if(title == 'This Month Budget') {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'budgetAmount' : value,
                      });
                      Get.back();
                    }


                    print('amount: $value');

                  }

                  if(!isAmount) {
                    name = textEditingController.text.capitalize;

                    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                      'username' : name,
                    });

                    Get.back();

                    print('name : $name');

                  }

                } else {
                  Fluttertoast.showToast(msg: 'Please fill the field',gravity: ToastGravity.TOP);
                }

              },
              icon: const Icon(Icons.done,color: Colors.white,size: 30,),
            ),
            const SizedBox(width: 10,)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: textEditingController,
                keyboardType: isAmount ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.name,
                cursorColor: Colors.white.withOpacity(.7),
                style: TextStyle(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 17,
                  decoration: TextDecoration.none
                ),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(.9),
                          width: 2
                      )
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(.6),
                          width: 2
                      )
                  ),
                  suffixText: currency,
                  suffixStyle: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontSize: 18
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:mywallet/pages/start%20up%20pages/target_add_page.dart';
import 'package:mywallet/services/database.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';

import '../../constant/colors.dart';

class BalanceAddPage extends StatefulWidget {
  const BalanceAddPage({super.key});

  @override
  State<BalanceAddPage> createState() => _BalanceAddPageState();
}

class _BalanceAddPageState extends State<BalanceAddPage> {

  TextEditingController amountEditingController = TextEditingController();

  String error = '';

  var database = Database();

  String currency = '';


  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot> stream = FirebaseFirestore.instance.collection('users').doc('${FirebaseAuth.instance.currentUser!.uid}').snapshots();

    stream.forEach((element) {

      setState(() {
        currency = element['currency'];
      });
    });

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 20,),

                Text('Here, Enter your',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 19,
                      color: Colors.white.withOpacity(.6)
                  ),
                ),

                Text('Current wallet balance',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      color: Colors.white.withOpacity(.7)
                  ),
                ),

                const SizedBox(height: 50,),

                Lottie.asset('assets/lottie/balance.json'),

                const SizedBox(height: 10,),

                Component1(
                    context,
                    const Text(''),
                    icon: Iconsax.coin,
                    hintText: 'Your current balance',
                    controller: amountEditingController,
                    isAmount: true,
                    error: error,
                    currency: currency,
                ),

                const SizedBox(height: 60,),

                Component2(
                  context,
                  onTap: (){

                    if(amountEditingController.text.isEmpty) {
                      setState(() {
                        error = 'Please add your Wallet balance';
                      });
                    }

                    if(amountEditingController.text.isNotEmpty) {
                      setState(() {
                        error = '';
                      });
                    }

                    if(error == '') {

                      double amount = double.parse(amountEditingController.text.trim());

                      var data = {'remainingAmount' : amount, 'budgetAmount' : amount};

                      database.updateUser(data, context);

                      Get.to(()=>const TargetAddPage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 300));

                    }

                  },
                  title: 'Next >',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

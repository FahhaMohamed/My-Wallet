import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mywallet/widgets/decoration_components/background.dart';
import 'package:mywallet/widgets/loan%20components/loaners_tabBar.dart';
import 'package:mywallet/widgets/loan%20components/radial_indicator.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({Key? key}) : super(key: key);

  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {

  String currency = '';

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){

            currency = value['currency'];

    });

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Background(context,
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'Loan payments',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white.withOpacity(.6),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(
                      height: 30,
                    ),


                    RadialIndicator(context),

                    const SizedBox(
                      height: 50,
                    ),

                    LoanersTabBar(currency: currency)

                  ],
                ),
              ))),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: w,
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                      Colors.transparent
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

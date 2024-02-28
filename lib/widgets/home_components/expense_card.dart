
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ExpenseCard(BuildContext context,{required String userId}) {

  Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

  return StreamBuilder<DocumentSnapshot>(

    stream: _userStream,

    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

      if(snapshot.hasError) {

        return Text('Something went wrong!!!', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.bold),);

      } else if(snapshot.connectionState == ConnectionState.waiting) {

        return Center(child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SpinKitRipple(color: Colors.white.withOpacity(.7),size: 20,),
        ));

      } else if(!snapshot.hasData || !snapshot.data!.exists) {

        return Center(child: Text('Oops!!!, no data found', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.bold),));

      } else if(snapshot.hasData) {

        var data  = snapshot.data!.data() as Map<dynamic, dynamic>;

        return Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 229, 180, 106),
                    Color.fromARGB(255, 229, 223, 106),
                    Color.fromARGB(255, 229, 180, 106),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(3, 3)
                )
              ],
              border: Border.all(
                color: const Color.fromARGB(255, 229, 223, 106),
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/home/expense.png',color: Colors.black,
                width: 60,
              ).animate().slideX(begin: 10, duration: const Duration(milliseconds: 900), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 400)),
              const SizedBox(
                height: 30,
              ),
              Text('${data['currency']} ${data['expense']}',
                style: GoogleFonts.abel(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ).animate().slideX(begin: 10, duration: const Duration(milliseconds: 900), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 600)),
              const Text('My expense',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ).animate().slideX(begin: 10, duration: const Duration(milliseconds: 900), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 800)),
            ],
          ),
        ).animate().slideX(begin: 1, duration: const Duration(milliseconds: 900), curve: Curves.fastEaseInToSlowEaseOut).shimmer(delay: const Duration(milliseconds: 1700));

      } else {

        return const Center(child: CircularProgressIndicator(color: Colors.white,),);

      }
    },
  );


}
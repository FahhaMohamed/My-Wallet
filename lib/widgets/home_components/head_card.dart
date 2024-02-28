import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


Widget HeadCard (

    BuildContext context,
    {
      required String userId,
    }

    )

{

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
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(168, 85, 4, 35)),
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 143, 20, 104),
                  Color.fromARGB(255, 255, 0, 136),
                  Color.fromARGB(255, 250, 78, 124),
                  Color.fromARGB(255, 235, 1, 126),
                  Color.fromARGB(255, 143, 20, 104),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(186, 180, 3, 70),
                    offset: Offset(3, 3),
                    blurRadius: 2,
                  ),
                ]),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available balance',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ).animate().slide(duration: const Duration(milliseconds: 1100),curve: Curves.bounceOut),
                        Text(
                          data['remainingAmount'] != null ? '${data['currency']} ${data['remainingAmount']}' : '${data['currency']} 0',
                          style: GoogleFonts.abel(
                              fontWeight: FontWeight.w500,
                              fontSize: 40
                          ),
                        ).animate().slide(duration: const Duration(milliseconds: 1100),curve: Curves.bounceOut),
                        const Spacer(),
                      ]),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(186, 180, 3, 70),
                              offset: Offset(3, 3),
                              blurRadius: 2,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Icon(Icons.circle_outlined,color: Colors.black,),
                            const Text(
                              ' This month budget',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              data['budgetAmount'] != null ? ' ${data['currency']} ${data['budgetAmount']}' : ' ${data['currency']} 0',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().shimmer(delay: const Duration(milliseconds: 1700)),
                  ],
                ),
              ],
            )
        ).animate().slide(duration: const Duration(milliseconds: 800),curve: Curves.bounceOut);

      } else {

        return const Center(child: CircularProgressIndicator(color: Colors.white,),);

      }
    },
  );
}
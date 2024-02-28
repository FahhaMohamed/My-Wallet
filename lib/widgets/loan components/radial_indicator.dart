import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:mywallet/constant/colors.dart';
import 'package:mywallet/widgets/loan%20components/add_new_loaner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

  Widget RadialIndicator(BuildContext context) {

    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(

      stream: _userStream,

      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if(snapshot.hasError) {

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Oops!!!', style: TextStyle(color: Colors.red.withOpacity(.7),fontSize: 25,fontWeight: FontWeight.w500),),
              Text('Something went wrong.', style: TextStyle(color: Colors.red.withOpacity(.7),fontSize: 15,fontWeight: FontWeight.w500),),
            ],
          );

        } else if(snapshot.connectionState == ConnectionState.waiting) {

          return Center(child: CircularProgressIndicator(color: CustomColor.purple[0],),);

        } else if(!snapshot.hasData || !snapshot.data!.exists) {

          return Container();

        } else if(snapshot.hasData) {

          var data  = snapshot.data!.data() as Map<dynamic, dynamic>;

          int dev = 1;
          double totalCredit = data['totalCredit'];
          double totalDebit = data['totalDebit'];


          if(totalDebit > totalCredit) {

            for(int i =0; i<((totalDebit.round()).toString().length) - 2;i++) {
              dev = dev * 10;
            }

          } else {

            for(int i =0; i<((totalCredit.round()).toString().length) - 2;i++) {
              dev = dev * 10;
            }

          }

          double valDebit = totalDebit/dev;

          if(valDebit < 0){valDebit = 0;}
          if(valDebit > 100){valDebit = 100;}

          double valCredit = totalCredit/dev;

          if(valCredit < 0){valCredit = 0;}
          if(valCredit > 100){valCredit = 100;}


          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: RadialGauge(
                          track: RadialTrack(
                              steps: 1,
                              color: Colors.black,
                              thickness: 8,
                              startAngle: -90,
                              endAngle: 360,
                              start: 0,
                              end: 100,
                              hideLabels: true,
                              trackStyle: TrackStyle(
                                  secondaryRulerColor:
                                  Colors.white.withOpacity(.5),
                                  showFirstLabel: false,
                                  showLastLabel: false,
                                  showLabel: false,
                                  showSecondaryRulers: false)),
                          valueBar: [
                            RadialValueBar(
                              value: valDebit,
                              valueBarThickness: 10,
                              color: Colors.green.shade500,
                            )
                          ],
                        ),
                      ),
                      ZoomTapAnimation(
                        child: Icon(Icons.add_circle,color: Colors.green.shade500,size: 30,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewLoaner(title: 'Debtor')));
                        },
                      ),
                    ],
                  ).animate().slideX(begin: -1, duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut),

                  const SizedBox(
                    height: 5,
                  ),

                  Text('$totalDebit ${data['currency']}',
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontSize: 19,
                    ),
                  ).animate().slideX(begin: -10, duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 300)),

                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Debtors',
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontSize: 15,
                    ),
                  ).animate().scale( duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 500)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Creditors',
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 15,
                    ),
                  ).animate().scale( duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 800)),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: RadialGauge(
                          track: RadialTrack(
                              steps: 1,
                              color: Colors.black,
                              thickness: 8,
                              startAngle: -90,
                              endAngle: 360,
                              start: 0,
                              end: 100,
                              hideLabels: true,
                              trackStyle: TrackStyle(
                                  secondaryRulerColor:
                                  Colors.white.withOpacity(.5),
                                  showFirstLabel: false,
                                  showLastLabel: false,
                                  showLabel: false,
                                  showSecondaryRulers: false)),
                          valueBar: [
                            RadialValueBar(
                              value: valCredit,
                              valueBarThickness: 10,
                              color: Colors.red.shade900,
                            )
                          ],
                        ),
                      ),
                      ZoomTapAnimation(
                        child: Icon(Icons.add_circle,color: Colors.red.shade900,size: 30,),
                        onTap: (){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewLoaner(title: 'Creditor')));

                        },
                      ),
                    ],
                  ).animate().slideX(begin: 1, duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut),
                  const SizedBox(
                    height: 5,
                  ),

                  Text(''
                      '$totalCredit ${data['currency']}',
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 19,
                    ),
                  ).animate().slideX(begin: 10, duration: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut, delay: const Duration(milliseconds: 300)),
                ],
              ),

            ],
          );

        } else {

          return const Center(child: CircularProgressIndicator(color: Colors.white,),);

        }
      },
    );
  }


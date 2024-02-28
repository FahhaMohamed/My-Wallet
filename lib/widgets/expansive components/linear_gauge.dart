import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:mywallet/constant/colors.dart';

import '../decoration_components/shimmer_effect.dart';


class CustomLinearGauge extends StatefulWidget {

  final String monthyear;

  const CustomLinearGauge({super.key, required this.monthyear});

  @override
  State<CustomLinearGauge> createState() => _CustomLinearGaugeState();
}

class _CustomLinearGaugeState extends State<CustomLinearGauge> {


  bool isDown = false;

  @override
  Widget build(BuildContext context) {

    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('usages')
        .doc(widget.monthyear)
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

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ShimmerEffect(context),
          );

        } else if(!snapshot.hasData || !snapshot.data!.exists) {

          return Container();

        } else if(snapshot.hasData) {

          var data  = snapshot.data!.data() as Map<dynamic, dynamic>;

          int dev = 1;
          double income = data['income'];
          double expense = data['expense'];

          if(income > expense) {

            for(int i =0; i<((income.round()).toString().length) - 2;i++) {
              dev = dev * 10;
            }

          } else {

            for(int i =0; i<((expense.round()).toString().length) - 2;i++) {
              dev = dev * 10;
            }

          }

          double valIncome = income/dev;

          if(valIncome < 0){valIncome = 0;}
          if(valIncome > 100){valIncome = 100;}

          double valExpense = expense/dev;

          if(valExpense < 0){valExpense = 0;}
          if(valExpense > 100){valExpense = 100;}


          return Padding(

            padding: const EdgeInsets.only(left: 10.0, right: 10,top: 5,bottom: 5),

            child: Container(

              decoration: BoxDecoration(
                  color: CustomColor.purple[2].withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(3, 3)
                    )
                  ]
              ),

              child: Padding(

                padding: const EdgeInsets.only(left: 5.0, right: 5,top: 10,bottom: 15),

                child: Column(
                  children: [

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle_outlined,color: Color.fromARGB(255, 77, 140, 0),),
                        SizedBox(width: 5,),
                        Text('Income',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 15,),
                        Icon(Icons.circle_outlined,color: Color.fromARGB(255, 124, 2, 2),),
                        SizedBox(width: 5,),
                        Text('Expense',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                      ],
                    ),

                    LinearGauge(
                      linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(
                        thickness: 8,
                        borderRadius: 20,
                        backgroundColor: Colors.black,
                      ),
                      start: 0,
                      end: 100,
                      rulers: RulerStyle(
                        rulerPosition: RulerPosition.top,
                        showPrimaryRulers: false,
                        showSecondaryRulers: false,
                        showLabel: false,

                      ),
                      valueBar: [
                        ValueBar(
                          value: valIncome,
                          valueBarThickness: 10,
                          borderRadius: 20,
                          animationType: Curves.fastEaseInToSlowEaseOut,
                          animationDuration: 1500,
                          color: const Color.fromARGB(255, 77, 140, 0),
                        ),
                      ],
                    ),

                    LinearGauge(
                      linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(
                        thickness: 8,
                        borderRadius: 20,
                        backgroundColor: Colors.black,
                      ),
                      start: 0,
                      end: 100,
                      rulers: RulerStyle(
                        rulerPosition: RulerPosition.top,
                        showPrimaryRulers: false,
                        showSecondaryRulers: false,
                        showLabel: false,

                      ),
                      valueBar: [
                        ValueBar(
                          value: valExpense,
                          valueBarThickness: 10,
                          borderRadius: 20,
                          animationType: Curves.fastEaseInToSlowEaseOut,
                          animationDuration: 1500,
                          color: const Color.fromARGB(
                              255, 124, 2, 2),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          );

        } else {

          return const Center(child: CircularProgressIndicator(color: Colors.white,),);

        }
      },
    );

  }
}

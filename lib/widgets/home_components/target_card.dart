import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget TargetCard (
    BuildContext context,
    {

      required String month,
      required String userId

    }) {

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
          decoration:  BoxDecoration(
              color: const Color.fromARGB(255, 87, 10, 71),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(3, 3)
                )
              ]
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Target for',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(month,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const Spacer(),
                  Text(data['targetAmount'] != null ? '${data['currency']} ${data['targetAmount']}' : '${data['currency']} 0',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ],
          ).animate().scale(curve: Curves.fastEaseInToSlowEaseOut,duration: const Duration(milliseconds: 1300)),
        ).animate().scale(curve: Curves.fastEaseInToSlowEaseOut,duration: const Duration(milliseconds: 1000));

      } else {

        return const Center(child: CircularProgressIndicator(color: Colors.white,),);

      }
    },
  );

}
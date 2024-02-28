import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../decoration_components/shimmer_effect.dart';
import '../home_components/transaction_card.dart';

class TranscationList extends StatelessWidget {

  final String category;
  final String date;
  final String monthyear;
  final bool isIncome;

  TranscationList({
    super.key,

    required this.category,
    required this.monthyear,
    required this.isIncome,
    required this.date,

  });

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    var userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .where('monthyear', isEqualTo: monthyear)
        .where('isIncome', isEqualTo: isIncome);

    if(category != 'All') {

      userStream = userStream.where('category', isEqualTo: category);

    }

    if(date != '0') {

      userStream = userStream.where('day', isEqualTo: int.parse(date));

    }

    return FutureBuilder<QuerySnapshot> (
      future : userStream.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

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

        } else if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/itemno.webp'),
              const SizedBox(height: 20,),
              //Text('Oops!!!', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.w400),),
              Text('No Transactions found.', style: TextStyle(color: Colors.yellow.shade100,fontSize: 18,fontWeight: FontWeight.w400),),
            ],
          );

        } else if(snapshot.hasData) {

          var transData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: transData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {

              var data = transData[index];

              return Padding(

                padding: const EdgeInsets.only(left: 10.0, right: 10),

                child: TransactionCard(context, data: data),

              );

            },
          );

        } else{

          return Center(child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SpinKitRipple(color: Colors.white.withOpacity(.7),size: 20,),
          ));

        }

      },
    );

  }
}

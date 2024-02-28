import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mywallet/widgets/loan%20components/loaners_card.dart';

import '../decoration_components/shimmer_effect.dart';

class LoanersList extends StatelessWidget {

  final String currency;
  final String type;

  LoanersList({
    super.key,

    required this.currency,
    required this.type,

  });

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    var userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('loaners')
        .orderBy('order', descending: true)
        .where('type', isEqualTo: type);


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
              if(type == 'Creditor')
                Text('No Creditors found.', style: TextStyle(color: Colors.yellow.shade100,fontSize: 18,fontWeight: FontWeight.w400),),
              if(type == 'Debtor')
                Text('No Debtors found.', style: TextStyle(color: Colors.yellow.shade100,fontSize: 18,fontWeight: FontWeight.w400),),

            ],
          );

        } else if(snapshot.hasData) {

          var loanData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: loanData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {

              var data = loanData[index];

              return LoanersCard(context, data: data, currency: currency);

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

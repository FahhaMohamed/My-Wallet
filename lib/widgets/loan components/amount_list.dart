import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mywallet/widgets/loan%20components/amountlistCard.dart';

import '../decoration_components/shimmer_effect.dart';

class AmountList extends StatelessWidget {

  final String id;
  final String currency;

  const AmountList({super.key, required this.id, required this.currency});

  @override
  Widget build(BuildContext context) {

    final _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('loaners')
        .doc(id)
        .collection('items');

    return StreamBuilder<QuerySnapshot>(
      stream: _userStream
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong!!!',
            style: TextStyle(
                color: Colors.white.withOpacity(.7),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          );
        } else if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return ShimmerEffect(context);
        } else if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/itemno.webp'),
              const SizedBox(
                height: 20,
              ),
              //Text('Oops!!!', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.w400),),
              Text(
                'No Data found.',
                style: TextStyle(
                    color: Colors.yellow.shade100,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          var transData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: transData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              var data = transData[index];

              return AmountListCard(context, data: data, currency: currency);
            },
          );
        } else {
          return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SpinKitRipple(
                  color: Colors.white.withOpacity(.7),
                  size: 20,
                ),
              ));
        }
      },
    );

  }
}

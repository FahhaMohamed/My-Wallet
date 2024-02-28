import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../constant/colors.dart';

Widget DateData(BuildContext context,
    {required String userId, required String monthyear}) {
  Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('usages')
      .doc(monthyear)
      .collection('days')
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _userStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text(
          '!!!',
          style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          width: 40,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                period: const Duration(milliseconds: 1000),
                baseColor: CustomColor.purple[3].withOpacity(.5),
                highlightColor: CustomColor.purple[3],
                child: Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.purple[3], width: 3),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  height: 40,
                ),
              );
            },
          ),
        );
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Container();
      } else if (snapshot.hasData) {
        var data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          itemBuilder: (context, i) {
            var item = data[i];
            int date = item['day'];

            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                '$date',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
            );
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    },
  );
}

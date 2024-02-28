import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/colors.dart';


Widget ShimmerEffect(BuildContext context) {

  return ListView.builder(
    itemCount: 10,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor:  CustomColor.purple[3].withOpacity(.5),
        highlightColor: CustomColor.purple[3],
        period: const Duration(milliseconds: 1000),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10,),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              border: Border.all(
                  color: CustomColor.purple[3],
                  width: 3
              ),
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(3, 3)
                )
              ]
          ),
          height: 100,
        ),
      );
    },
  );

}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/colors.dart';

Widget LoanerPic(BuildContext context ,{required String avatar, required double size}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.7),
      borderRadius: BorderRadius.circular(size),
    ),
    child: ClipOval(
      child: CachedNetworkImage(
        imageUrl: avatar,
        placeholder: (context, url) =>  Shimmer.fromColors(

          period: const Duration(milliseconds: 1000),
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            width: size,
            decoration: BoxDecoration(
              border: Border.all(
                  color: CustomColor.purple[3],
                  width: 3
              ),
              color: Colors.black,
              borderRadius: BorderRadius.circular(size),
            ),
            height: size,
          ),
        ), //Image.asset('assets/user.png'),
        errorWidget: (context, url,error) => Image.asset('assets/user.png'),
      ),
    ),
  );
}
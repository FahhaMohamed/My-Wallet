import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mywallet/constant/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

Widget CustomButton(BuildContext context,{required VoidCallback onTap, required String title}) {

  return ClipRRect(

    borderRadius: BorderRadius.circular(15),

    child: BackdropFilter(

      filter: ImageFilter.blur(sigmaY: 15,sigmaX: 15),

      child: ZoomTapAnimation(

        child: InkWell(

          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,

          onTap: onTap,

          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              //color: CustomColor.purple[0].withOpacity(.3),
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  CustomColor.purple[0].withOpacity(.6),
                  CustomColor.purple[0].withOpacity(.4),
                  CustomColor.purple[0].withOpacity(.3),
                  CustomColor.purple[0].withOpacity(.3),
                  CustomColor.purple[0].withOpacity(.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 16
              ),
            ),
          ),
        ),
      ),
    ),
  );

}
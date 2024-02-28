import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

Widget Component2 (BuildContext context,{required VoidCallback onTap, required String title}) {

  return Padding(

    padding: const EdgeInsets.all(20.0),

    child: ClipRRect(

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
                color: Colors.white.withOpacity(.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(.8),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
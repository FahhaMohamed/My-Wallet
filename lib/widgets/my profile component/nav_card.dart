import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constant/colors.dart';

Widget NavCard (BuildContext context,{required String title, required IconData icon, required VoidCallback onTap,}) {

  return ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      padding:
      const EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: CustomColor.purple[2].withOpacity(.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(3, 3))
          ]),
      child: Row(
        children: [
          Icon(icon,color: Colors.white,size: 25,),
          const SizedBox(width: 15,),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    ),
  );


}
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

Widget Background(BuildContext context, {required child}) {

  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Container(

      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(

          gradient: LinearGradient(
              colors: [

                Color.fromARGB(255, 31, 1, 27),
                Color.fromARGB(255, 5, 6, 7),

                ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
          ),
        ),

      child: child,

    ),
  );
}
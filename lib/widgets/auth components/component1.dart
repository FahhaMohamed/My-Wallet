import 'dart:ui';

import 'package:flutter/material.dart';

Widget Component1 (BuildContext context, Widget suffix,  {required TextEditingController controller, required IconData icon, required String hintText, bool isPassword = false, bool isEmail = false, bool isAmount = false, String error = '', String currency = '',bool isSecurePass = true, bool isPhone = false}/*IconData icon, , */) {


  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0,),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 10, ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            onChanged: (val){
              if(isPhone) {
                if(val.length <= 0 ) {
                  controller.text = '+';
                }
              }
            },
            style: TextStyle(
              color: Colors.white.withOpacity(.8),
            ),
            cursorColor: Colors.white,
            obscureText: isPassword ? isSecurePass : false,
            keyboardType: isEmail? TextInputType.emailAddress : isPassword ? TextInputType.visiblePassword : isAmount? const TextInputType.numberWithOptions(decimal: true) : TextInputType.name,
            decoration: isPassword
                ? InputDecoration(
              suffixIcon: suffix,
              prefixIcon: Icon(icon, color: Colors.white.withOpacity(.7),),
              border: InputBorder.none,
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(.5),
              ),
              error: error != ''
                  ? Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  error,
                  style: TextStyle(
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(0, 0),
                          blurRadius: 3,
                        )
                      ],
                      color: Colors.pink.withOpacity(.6),
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
                  : null,
            )
                : InputDecoration(
              suffixText: isAmount ? currency : null,
              suffixStyle: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 17
              ),
              prefixIcon: Icon(icon, color: Colors.white.withOpacity(.7),),
              border: InputBorder.none,
              hintText: hintText,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(.5),
              ),
              error: error != ''
                  ? Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    error,
                    style: TextStyle(
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 3,
                      )
                    ],
                    color: Colors.pink.withOpacity(.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
                  : null,
            ),
          ),
        ),
      ),
    ),
  );
}
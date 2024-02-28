import 'package:flutter/material.dart';
import '../../constant/colors.dart';


Widget CustomForm ({

  required String labelText,
  bool suffix = false,
  String currency = '',
  bool isDescription = false,
  required TextEditingController controller,
  String error = '',
  bool  isAmount = false,
  bool  isPhone = false,

}) {

  if(isPhone) {
    controller.text = '+';
  }

  return Container(
    alignment: Alignment.center,
    padding: isDescription ? const EdgeInsets.only(left: 0, ) : const EdgeInsets.only(left: 35, right: 35),
    child: TextFormField(
      onChanged: (val){
        if(isPhone) {
          if(val.length <= 0 ) {
            controller.text = '+';
          }
        }
      },
      keyboardType: isAmount ? const TextInputType.numberWithOptions(decimal: true, signed: true) : TextInputType.name,
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: CustomColor.purple[0],
      decoration: InputDecoration(
        suffixText: suffix ? currency : null,
        suffixStyle: const TextStyle(color: Colors.white70,fontSize: 17),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 0, 183),
                width: 3
            )
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: CustomColor.purple[0],
                width: 3
            )
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 19,
          color: Color.fromARGB(200, 255, 0, 183),
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 19,
          color: Color.fromARGB(255, 255, 0, 183),
          fontWeight: FontWeight.w500,
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
  );

}
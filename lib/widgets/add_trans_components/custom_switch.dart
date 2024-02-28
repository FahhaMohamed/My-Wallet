import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomSwich({bool isOn = false, required ValueChanged<bool>? onChanged,required String title}) {

  return Row(
    children: [
      Text(title,
          style: TextStyle(
            color: isOn ? const Color.fromARGB(255, 255, 0, 183) : Colors.grey.shade600,
            fontSize: 19,
          ),
        ),

      const Spacer(),
      Transform.scale(
        scale: 0.8,
        child: Switch(
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.grey.shade700,
          activeColor: Colors.black,
          activeTrackColor: const Color.fromARGB(255, 255, 0, 183),
          value: isOn,
          onChanged: onChanged,
        ),
      ),
    ],
  );

}
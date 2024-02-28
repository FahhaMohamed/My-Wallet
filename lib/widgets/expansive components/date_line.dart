import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/constant/categories.dart';

class DateLine extends StatefulWidget {

  final ValueChanged<String?> onChanged;

  const DateLine({super.key, required this.onChanged});

  @override
  State<DateLine> createState() => _DateLineState();
}

class _DateLineState extends State<DateLine> {

  String currentDate = '0';


  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 40,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: 32,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: (){
              setState(() {
                currentDate = index.toString();
                widget.onChanged(index.toString());
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10,right: 10),
              padding: const EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                  color: currentDate == index.toString() ? Colors.white.withOpacity(.7) : Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black,width: 2)
              ),
              child: Text(
                index == 0 ? 'All' : '$index',
                style: currentDate == index.toString() ? const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                ) : const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                ),
              ),
            ),
          );

        },

      ),

    );

  }
}

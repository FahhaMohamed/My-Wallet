import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/constant/colors.dart';

class DateDayLine extends StatefulWidget {
  const DateDayLine({super.key});

  @override
  State<DateDayLine> createState() => _DateDayLineState();
}

class _DateDayLineState extends State<DateDayLine> {

  String currentDate = '';
  String currentDay = '';

  List<String> days = [];

  @override
  void initState() {

    super.initState();

    DateTime now = DateTime.now();

    for(int i = -31 ; i <= 0 ; i++) {

      days.add(
        DateFormat('d').format(DateTime(now.year, now.day))
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return Container(
            width: 80,
            margin: const EdgeInsets.only(left: 10,right: 10),
            padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: CustomColor.pink[3],
              ),
            ),
            child: Center(
                child: Text(days[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.6)
                  ),
                ),
            ),
          );

        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearLine extends StatefulWidget {

  final ValueChanged<String?> onChanged;

  const MonthYearLine({super.key, required this.onChanged});

  @override
  State<MonthYearLine> createState() => _MonthYearLineState();
}

class _MonthYearLineState extends State<MonthYearLine> {

  final scrollController = ScrollController();

  String currentMonth = '';

  List<String> months = [];

  @override
  void initState() {

    super.initState();

    DateTime now = DateTime.now();
    print(now);

    for(int i = -23 ; i <= 0 ; i++ ) {

      months.add(
        DateFormat('MMM y').format(DateTime(now.year, now.month + i))
      );

    }

    currentMonth = DateFormat('MMM y').format(now);

    Future.delayed(const Duration(milliseconds: 500), () {
      scrollToSelectedMonth();
    });

  }

  scrollToSelectedMonth() {
    final selectedMonthIndex = months.indexOf(currentMonth);

    if(selectedMonthIndex == 23) {

      scrollController.animateTo(4000.0, duration: const Duration(milliseconds: 4500), curve: Curves.fastEaseInToSlowEaseOut);

    }

  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 40,

      child: ListView.builder(

        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        itemBuilder: (context, index) {

          return GestureDetector(
            onTap: (){
              setState(() {
                currentMonth = months[index];
                widget.onChanged(months[index]);
              });
              scrollToSelectedMonth();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10,right: 10),
              padding: const EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                color: currentMonth == months[index] ? Colors.white.withOpacity(.7) : Colors.white.withOpacity(.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black,width: 2)
              ),
              child: Center(
                  child: Text(
                      months[index],
                    style: currentMonth == months[index] ? const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    ) : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),
                  ),),
            ),
          );

        },

      ),

    );

  }
}

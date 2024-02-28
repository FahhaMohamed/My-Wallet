import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';

Widget AmountListCard(BuildContext context, {required data, required String currency}) {

  DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);

  String time = DateFormat('d MMM hh:mma').format(date);

  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(top: 10, bottom: 10, right: 20,left: 20),
    decoration: BoxDecoration(
        color: CustomColor.purple[2].withOpacity(.5),
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(3, 3))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(data['title'],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                ),
              ),
              const Spacer(),
              Text('$currency ${data['amount']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
            ],
          ),
          Row(
            children: [
              const Text('Balance',
                style: TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                ),
              ),
              const Spacer(),
              Text('$currency ${data['total']}',
                style: const TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Column(
            children: [
              const SizedBox(height: 10,),
              Text(time,
                style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

}
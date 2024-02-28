import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/constant/categories.dart';
import '../../constant/colors.dart';

Widget TransactionCard(

    BuildContext context,
    {

      required data,

    }

  )
{

  DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);

  String time = DateFormat('d MMM hh:mma').format(date);

  IconData icon = iconList['${data['category']}'];

  return Container(
    margin: const EdgeInsets.only(bottom: 10, top: 10,),
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        border: Border.all(
            color: CustomColor.purple[3],
            width: 3
        ),
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              color: Colors.black,
              offset: Offset(3, 3)
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(data['item'],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),
              ),
              const Spacer(),
              if(data['isIncome'])
                Text('+ ${data['currency']} ${data['transactionAmount']}',
                  style: TextStyle(
                      color: Colors.lightGreen.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
              if(!data['isIncome'])
                Text('- ${data['currency']} ${data['transactionAmount']}',
                  style: const TextStyle(
                      color: Color.fromARGB(
                          255, 194, 1, 1),
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
              Text('${data['currency']} ${data['balanceAmount']}',
                style: const TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if(data['description'] != '')
            Column(
              children: [
                const SizedBox(height: 5,),
                Text(data['description'],
                  style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  ),
                ),
              ],
            ),
          Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(time,
                    style: TextStyle(
                        color: CustomColor.purple[1],
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  ),
                  const Spacer(),
                  Icon(icon, color: CustomColor.purple[1],size: 30,)
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );

}
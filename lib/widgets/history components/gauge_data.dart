import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mywallet/widgets/history%20components/date_data.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../constant/colors.dart';

Widget GaugeData(BuildContext context, {required String userId}) {
  Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('usages')
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _userStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text(
          'Something went wrong!!!',
          style: TextStyle(
              color: Colors.white.withOpacity(.7),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  period: const Duration(milliseconds: 1000),
                  baseColor: CustomColor.purple[3].withOpacity(.5),
                  highlightColor: CustomColor.purple[3],
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: CustomColor.purple[3], width: 3),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 400,
                  ),
                );
              },
            ),
          ),
        );
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/itemno.webp'),
            const SizedBox(
              height: 20,
            ),
            //Text('Oops!!!', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.w400),),
            Text(
              'No Transactions found.',
              style: TextStyle(
                  color: Colors.yellow.shade100,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      } else if (snapshot.hasData) {
        var data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          itemBuilder: (context, i) {
            var item = data[i];
            int dev = 1;
            String monthyear = item['monthyear'];
            String currency = item['currency'];
            double balance = item['remainingAmount'];
            double target = item['targetAmount'];
            double budget = item['budgetAmount'];
            double income = item['income'];
            double expense = item['expense'];

            if (income > expense) {
              for (int i = 0;
                  i < ((income.round()).toString().length) - 2;
                  i++) {
                dev = dev * 10;
              }
            } else {
              for (int i = 0;
                  i < ((expense.round()).toString().length) - 2;
                  i++) {
                dev = dev * 10;
              }
            }

            double valIncome = income / dev;

            if (valIncome < 0) {
              valIncome = 0;
            }
            if (valIncome > 100) {
              valIncome = 100;
            }

            double valExpense = expense / dev;

            if (valExpense < 0) {
              valExpense = 0;
            }
            if (valExpense > 100) {
              valExpense = 100;
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: CustomColor.purple[2].withOpacity(.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(3, 3))
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'D',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'A',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'T',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'E',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'S',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 40,
                      child: DateData(context,
                          userId: userId, monthyear: monthyear),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SfLinearGauge(
                      showLabels: false,
                      orientation: LinearGaugeOrientation.vertical,
                      ranges: const [
                        LinearGaugeRange(
                          rangeShapeType: LinearRangeShapeType.curve,
                          startWidth: 8,
                          endWidth: 8,
                          midWidth: 8,
                          position: LinearElementPosition.cross,
                          color: Colors.black,
                        ),
                      ],
                      barPointers: [
                        LinearBarPointer(
                          thickness: 10,
                          value: valIncome,
                          color: const Color.fromARGB(255, 77, 140, 0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SfLinearGauge(
                      showLabels: false,
                      orientation: LinearGaugeOrientation.vertical,
                      ranges: const [
                        LinearGaugeRange(
                          rangeShapeType: LinearRangeShapeType.curve,
                          startWidth: 8,
                          endWidth: 8,
                          midWidth: 8,
                          position: LinearElementPosition.cross,
                          color: Colors.black,
                        ),
                      ],
                      barPointers: [
                        LinearBarPointer(
                          thickness: 10,
                          value: valExpense,
                          color: const Color.fromARGB(255, 124, 2, 2),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //month year
                        Text(
                          monthyear,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.9),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(
                          height: 40,
                        ),

                        //Income
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.circle_outlined,
                                  color: Color.fromARGB(255, 77, 140, 0),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  'Income',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              '$income $currency',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //Expense
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.circle_outlined,
                                  color: Color.fromARGB(255, 124, 2, 2),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Expense',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              '$expense $currency',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //balance
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Wallet Balance',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '$balance $currency',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //target
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Your Target',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '$target $currency',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //budget
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Your Budget',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '$budget $currency',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    },
  );
}

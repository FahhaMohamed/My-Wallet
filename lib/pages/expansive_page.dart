import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/pages/expansive/tab_bar_view.dart';
import 'package:mywallet/widgets/decoration_components/background.dart';
import 'package:mywallet/widgets/expansive%20components/category_line.dart';
import 'package:mywallet/widgets/expansive%20components/date_line.dart';
import 'package:mywallet/widgets/expansive%20components/linear_gauge.dart';
import 'package:mywallet/widgets/expansive%20components/month_year.dart';
import 'package:shimmer/shimmer.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  String category = 'All';
  String date = '0';
  String monthyear = DateFormat('MMM y').format(DateTime.now());

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Background(
              context,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(height: 10,),

                      Text('Expansive details',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      const SizedBox(height: 20,),

                      MonthYearLine(
                        onChanged: (String? value){
                          if(value != null) {
                            setState(() {
                              monthyear = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 7,),

                      DateLine(onChanged: (value){
                        if(value != null) {
                          setState(() {
                            date = value;
                          });
                        }
                        print(date);
                      }),

                      const SizedBox(height: 20,),

                      CustomLinearGauge(monthyear: monthyear,),

                      const SizedBox(height: 20,),

                      CategoryLine(
                          onChanged: (String? value){
                            if(value != null) {
                              setState(() {
                                category = value;
                              });
                            }
                          },
                      ),

                      const SizedBox(height: 20,),

                      CustomTabBarView(category: category, monthyear: monthyear, date: date,),

                    ],
                  ),
                ),
              )
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

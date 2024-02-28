import 'package:flutter/material.dart';
import 'package:mywallet/constant/colors.dart';
import 'package:mywallet/widgets/expansive%20components/transaction_list.dart';

class CustomTabBarView extends StatefulWidget {

  final String category;
  final String date;
  final String monthyear;

  const CustomTabBarView({super.key, required this.category, required this.monthyear, required this.date});

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> {

  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.height - 185;

    return Container(
      height: size,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [

            TabBar(

              tabs: const [
                  Tab(text: 'INCOME',),
                  Tab(text: 'EXPENSE',),
                ],
              indicatorColor: CustomColor.purple[0],
              indicatorWeight: 5,
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: CustomColor.purple[0],
                  width: 5,
                )
              ),
              dividerColor: Colors.white.withOpacity(.5),
              dividerHeight: 0,
              labelColor: const Color.fromARGB(255, 208, 3, 180),
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
              unselectedLabelColor: Colors.white.withOpacity(.35),
            ),

            const SizedBox(height: 20,),
            Expanded(
              child: TabBarView(
                children: [

                  TranscationList(category: widget.category, monthyear: widget.monthyear, isIncome: true, date: widget.date,),

                  TranscationList(category: widget.category, monthyear: widget.monthyear, isIncome: false, date: widget.date),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

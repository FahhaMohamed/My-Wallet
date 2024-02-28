import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import 'loaners_list.dart';

class LoanersTabBar extends StatefulWidget {

  final String currency;

  const LoanersTabBar({super.key, required this.currency});

  @override
  State<LoanersTabBar> createState() => _LoanersTabBarState();
}

class _LoanersTabBarState extends State<LoanersTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 670,
      child: DefaultTabController(

        length: 2,

        child: Column(
          children: [

            TabBar(

              tabs: const [

                Tab(text: 'DEBTORS',),
                Tab(text: 'CREDITORS',),

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
              dividerHeight: 1,
              labelColor: Colors.white.withOpacity(.9),
              labelStyle: const TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.w400
              ),
              unselectedLabelColor: Colors.white.withOpacity(.35),
            ),

            const SizedBox(height: 20,),

            Expanded(
              child: TabBarView(
                children: [

                  LoanersList(currency: widget.currency, type: 'Debtor'),

                  LoanersList(currency: widget.currency, type: 'Creditor'),

                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}

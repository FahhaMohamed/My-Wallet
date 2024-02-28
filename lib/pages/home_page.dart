import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/constant/months.dart';
import 'package:mywallet/pages/main_page.dart';
import 'package:mywallet/widgets/decoration_components/background.dart';
import 'package:mywallet/widgets/home_components/income_card.dart';
import 'package:mywallet/widgets/home_components/transaction_card.dart';
import 'package:mywallet/widgets/home_components/username.dart';
import '../widgets/decoration_components/shimmer_effect.dart';
import '../widgets/home_components/expense_card.dart';
import '../widgets/home_components/head_card.dart';
import '../widgets/home_components/target_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userId = FirebaseAuth.instance.currentUser!.uid;

  final _userStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('transactions');

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Background(
            context,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      UsernameCard(context, userId: userId),

                      const SizedBox(
                        height: 10,
                      ),
                      HeadCard(
                        context,
                        userId: userId,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TargetCard(context,
                          month: Months.then[(DateTime.now().month) - 1],
                          userId: userId),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: w * 0.9,
                        child: Row(
                          children: [
                            IncomeCard(context, userId: userId),
                            const Spacer(),
                            ExpenseCard(context, userId: userId),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.donut_large,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Recent transactions',
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _userStream
                                .orderBy('timestamp', descending: true)
                                .limit(10)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                  'Something went wrong!!!',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ShimmerEffect(context);
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Column(
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
                                var transData = snapshot.data!.docs;

                                return ListView.builder(
                                  itemCount: transData.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemBuilder: (context, index) {
                                    var data = transData[index];

                                    return TransactionCard(context, data: data);
                                  },
                                );
                              } else {
                                return Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: SpinKitRipple(
                                    color: Colors.white.withOpacity(.7),
                                    size: 20,
                                  ),
                                ));
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () {
                            MainPage.navigationKey.currentState?.setPage(1);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'View all',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Iconsax.eye,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: w,
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.1),
                  Colors.transparent
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
            ),
          ),

          /*Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: w,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.1),
                    Colors.transparent,
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

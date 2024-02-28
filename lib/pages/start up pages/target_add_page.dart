import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:mywallet/pages/start%20up%20pages/auth/login_page.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';
import 'package:toasty_box/toast_service.dart';

import '../../constant/colors.dart';
import '../../services/database.dart';

class TargetAddPage extends StatefulWidget {
  const TargetAddPage({super.key});

  @override
  State<TargetAddPage> createState() => _TargetAddPageState();
}

class _TargetAddPageState extends State<TargetAddPage> {
  TextEditingController amountEditingController = TextEditingController();

  String error = '';

  var database = Database();

  String currency = '';

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> stream = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    stream.forEach((element) {
      setState(() {
        currency = element['currency'];
      });
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Here, Enter your',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 19, color: Colors.white.withOpacity(.6)),
                ),
                Text(
                  'Target for this month',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 20, color: Colors.white.withOpacity(.7)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Lottie.asset('assets/lottie/target.json'),
                const SizedBox(
                  height: 10,
                ),
                Component1(context, const Text(''),
                    icon: Iconsax.coin,
                    hintText: 'Your target',
                    controller: amountEditingController,
                    error: error,
                    currency: currency,
                    isAmount: true),
                const SizedBox(
                  height: 50,
                ),
                Component2(
                  context,
                  onTap: () {
                    if (amountEditingController.text.isNotEmpty) {
                      double amount =
                          double.parse(amountEditingController.text.trim());

                      var data = {'targetAmount': amount};

                      database.updateUser(data, context);

                      ToastService.showSuccessToast(
                        context,
                        message: 'Account Created Successfully.',
                      );

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    } else {

                      ToastService.showSuccessToast(
                        context,
                        message: 'Account Created Successfully.',
                      );

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    }
                  },
                  title: 'Finish',
                ),
                Component2(
                  context,
                  onTap: () {
                    Get.back();
                  },
                  title: '< Previous',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

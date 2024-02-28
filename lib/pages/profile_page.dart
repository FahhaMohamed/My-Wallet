import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/pages/profile/account_page.dart';
import 'package:mywallet/pages/profile/forgotpass_page.dart';
import 'package:mywallet/pages/profile/history_page.dart';
import 'package:mywallet/pages/profile/policies_page.dart';
import 'package:mywallet/pages/start%20up%20pages/auth/login_page.dart';
import 'package:mywallet/widgets/decoration_components/background.dart';
import 'package:mywallet/widgets/my%20profile%20component/nav_card.dart';
import 'package:toasty_box/toasty_box.dart';
import '../widgets/decoration_components/cached _image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  String username = 'Username';
  String email = '';
  String avatar =
      'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((data) {
      setState(() {
        username = data['username'];
        email = data['email'];
        avatar = data['avatar'];
      });
    });

    return Scaffold(
      body: Background(context,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.white.withOpacity(.7),
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'My Profile',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white.withOpacity(.7),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: ClipOval(
                              child: CachedImage(userId: userId),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                email,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.white.withOpacity(.6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().animate().slideX(
                        begin: 5,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(
                      height: 50,
                    ),

                    //Account
                    NavCard(context, title: 'Account', onTap: () {
                      Get.to(() => const AccountPage());
                    }, icon: Iconsax.user)
                        .animate()
                        .slideX(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(
                      height: 20,
                    ),

                    //My level
                    NavCard(context, title: 'History', onTap: () {
                      Get.to(() => const HistoryPage());
                    }, icon: Icons.history)
                        .animate()
                        .slideX(
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(
                      height: 20,
                    ),

                    //settings
                    //NavCard(context, title: 'Settings', onTap: (){}, icon: CupertinoIcons.settings).animate().slideX(duration: const Duration(milliseconds: 1400),curve: Curves.fastEaseInToSlowEaseOut),

                    //privacy policies
                    NavCard(context, title: 'Privacy policy', onTap: () {
                      Get.to(() => const PoliciesPage());
                    }, icon: Icons.policy_outlined)
                        .animate()
                        .slideX(
                            duration: const Duration(milliseconds: 1400),
                            curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(
                      height: 20,
                    ),

                    //forgot password
                    NavCard(context, title: 'Forgot password', onTap: () {
                      Get.to(() => const ForgotPage());
                    }, icon: IconlyLight.password)
                        .animate()
                        .slideX(
                            duration: const Duration(milliseconds: 1800),
                            curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(
                      height: 20,
                    ),

                    //Info
                    NavCard(context, title: 'Logout', onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              title: const Text('Confirmation!!!'),
                              titleTextStyle: TextStyle(
                                  color: Colors.red.withOpacity(.7),
                                  fontSize: 18),
                              content: Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Are you sure to Logout?',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7),
                                      fontSize: 16),
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withOpacity(.3)),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    ToastService.showSuccessToast(
                                      context,
                                      message: 'Logout Successfully.',
                                    );
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withOpacity(.3)),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                            );
                          });
                    }, icon: Icons.logout)
                        .animate()
                        .slideX(
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.fastEaseInToSlowEaseOut),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

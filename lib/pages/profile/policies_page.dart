import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/services/handlers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../constant/colors.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {

  Handlers handlers = Handlers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios,color: Colors.white.withOpacity(.7),size: 24,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: CustomColor.purple[3].withOpacity(0.8),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Privacy Policy for My Wallet',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5,),
                    Text('Last Updated: 22/02/2024',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: ClipOval(
                      child: Image.asset('assets/mypic.jpg'),
                    ),
                  ).animate().scale(curve: Curves.fastEaseInToSlowEaseOut,duration: const Duration(milliseconds: 1000)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: Image.asset('assets/appIcon.png'),
                    ),
                  ).animate().scale(curve: Curves.fastEaseInToSlowEaseOut,duration: const Duration(milliseconds: 1000)),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [

                    Text(
                      "It's MOHAMED FAHHAM, I am committed to protecting the privacy of my users. This Privacy Policy outlines how we collect, use, disclose, and protect the personal information you provide through My Wallet mobile application.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 17
                      ),
                      textAlign: TextAlign.start,
                    ).animate().slideX(duration: const Duration(milliseconds: 2000), curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(height: 15,),

                    Text(
                      'By using the App, you agree to the terms outlined in this Privacy Policy.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 17
                      ),
                      textAlign: TextAlign.start,
                    ).animate().slideX(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 200), curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(height: 20,),

                    const Divider().animate().slideX(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 400), curve: Curves.fastEaseInToSlowEaseOut),

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle_outlined,color: Colors.white.withOpacity(.9),),
                            const SizedBox(width: 5,),
                            Text(
                              'Information We Collect',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                  fontSize: 17
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ).animate().slideX(begin:-10,duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 1000), curve: Curves.fastEaseInToSlowEaseOut),

                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'We may collect personal information that you provide to us, such as your name, email address, and financial information when you register for an account or use certain features of the App.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 1000), curve: Curves.fastEaseInToSlowEaseOut),
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'The App may access and store financial information, including transaction details and account balances, to provide money management features.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 1200), curve: Curves.fastEaseInToSlowEaseOut),
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'The App may access and store financial information, including transaction details and account balances, to provide money management features.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 1400), curve: Curves.fastEaseInToSlowEaseOut),
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle_outlined,color: Colors.white.withOpacity(.9),),
                            const SizedBox(width: 5,),
                            Text(
                              'How We Use Your Information',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                  fontSize: 17
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ).animate().slideX(begin:-10,duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 2000), curve: Curves.fastEaseInToSlowEaseOut),

                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                "We may use data to analyze user behavior, improve the App's functionality, and enhance user experience.",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 2000), curve: Curves.fastEaseInToSlowEaseOut),

                      ],
                    ),

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle_outlined,color: Colors.white.withOpacity(.9),),
                            const SizedBox(width: 5,),
                            Text(
                              'Data Security',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                  fontSize: 17
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ).animate().slideX(begin:-10,duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 3000), curve: Curves.fastEaseInToSlowEaseOut),

                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'We employ industry-standard security measures to protect your personal information. However, no method of transmission over the internet or electronic storage is entirely secure, and we cannot guarantee absolute security.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 3000), curve: Curves.fastEaseInToSlowEaseOut),

                      ],
                    ),

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle_outlined,color: Colors.white.withOpacity(.9),),
                            const SizedBox(width: 5,),
                            Text(
                              'Data Sharing',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                  fontSize: 17
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ).animate().slideX(begin:-10,duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 4000), curve: Curves.fastEaseInToSlowEaseOut),

                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                'We may share your information with third-party service providers to facilitate App-related services (e.g., cloud storage, analytics). These third parties are obligated to maintain the confidentiality of your information.',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 4000), curve: Curves.fastEaseInToSlowEaseOut),

                      ],
                    ),

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle_outlined,color: Colors.white.withOpacity(.9),),
                            const SizedBox(width: 5,),
                            Text(
                              'Your Choices',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.9),
                                  fontSize: 17
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ).animate().slideX(begin:-10,duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 5000), curve: Curves.fastEaseInToSlowEaseOut),

                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 15),
                          decoration: BoxDecoration(
                              color: CustomColor.purple[2].withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(3, 3)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Text(
                                "You can access and update your personal information through the App's settings. You may also request the deletion of your account.",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.75),
                                    fontSize: 17
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ).animate().scale(duration: const Duration(milliseconds: 2000),delay: const Duration(milliseconds: 5000), curve: Curves.fastEaseInToSlowEaseOut),

                      ],
                    ),
                  ],
                ),
              ),

              const Divider(),

              const SizedBox(height: 20,),

              Text('Contact developer',
                style: GoogleFonts.aBeeZee(
                    color: Colors.white.withOpacity(.7),
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomTapAnimation(
                    child: Image.asset('assets/whatsapp.png',width: 50,height: 50,),
                    onTap: (){
                      handlers.openWhatsapp();
                    },
                  ),
                  const SizedBox(width: 15,),
                  ZoomTapAnimation(
                    child:const Icon(IconlyLight.message,color: Colors.white,size: 50,),
                    onTap: () async {
                      final Uri url = Uri.parse('mailto:fahhamohmad17@gmail.com?subject=From My Wallet App&body=Hello developer');


                      await launchUrl(url);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}

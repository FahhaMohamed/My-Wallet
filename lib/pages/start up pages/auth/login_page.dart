import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mywallet/pages/profile/forgotpass_page.dart';
import 'package:mywallet/pages/start%20up%20pages/auth/sign_in_page.dart';
import 'package:mywallet/services/auth_service.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../constant/colors.dart';
import '../../../services/scroll_behavior.dart';
import '../../../widgets/decoration_components/my_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isOn = false;

  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  bool _isSecurePassword = true;

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: Colors.grey,
    );
  }

  @override
  void initState() {
    //first
    controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    animation1 = Tween<double>(begin: .1, end: .15)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    animation2 = Tween<double>(begin: .02, end: .04)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    //second
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    animation3 = Tween<double>(begin: .41, end: .38)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    animation4 = Tween<double>(begin: 170, end: 190)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();

    super.dispose();
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool isShow = true;

  String errorPass = '';
  String errorMail = '';

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * (animation2.value + .58),
                    left: size.width * .23,
                    child: CustomPaint(
                      painter: MyPainter(50),
                    ),
                  ),
                  Positioned(
                    top: size.height * .98,
                    left: size.width * .1,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value - 30),
                    ),
                  ),
                  Positioned(
                    top: size.height * .5,
                    left: size.width * (animation2.value + .8),
                    child: CustomPaint(
                      painter: MyPainter(30),
                    ),
                  ),
                  Positioned(
                    top: size.height * animation3.value,
                    left: size.width * (animation1.value + .1),
                    child: CustomPaint(
                      painter: MyPainter(60),
                    ),
                  ),
                  Positioned(
                    top: size.height * .1,
                    left: size.width * .8,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Component1(context, const Text(''),
                          icon: CupertinoIcons.mail_solid,
                          hintText: 'Email address',
                          controller: emailEditingController,
                          isEmail: true,
                          error: errorMail),
                      Component1(context, togglePassword(),
                          isSecurePass: _isSecurePassword,
                          icon: CupertinoIcons.lock_fill,
                          hintText: 'Password',
                          isPassword: true,
                          controller: passwordEditingController,
                          error: errorPass),

                      Component2(
                        context,
                        onTap: () {
                          String email = emailEditingController.text.trim();
                          String password =
                              passwordEditingController.text.trim();

                          if (email.isEmpty) {
                            setState(() {
                              errorMail = 'Enter your email address';
                            });
                          }

                          if (email.isNotEmpty) {
                            setState(() {
                              errorMail = '';
                            });
                          }

                          if (password.isEmpty) {
                            setState(() {
                              errorPass = 'Enter the correct password';
                            });
                          }

                          if (password.isNotEmpty) {
                            setState(() {
                              errorPass = '';
                            });
                          }

                          if (errorMail == '' && errorPass == '') {
                            var data = {
                              'email': email,
                              'password': password,
                            };

                            authService.loginUser(data, context);
                          }
                        },
                        title: 'LOGIN',
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ZoomTapAnimation(
                              onTap: () {
                                Get.to(()=> const ForgotPage());
                              },
                              child: Text(
                                "Forgot password?",
                                style: GoogleFonts.abel(
                                    fontSize: 16,
                                    color: CustomColor.purple[0],
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      const Shadow(
                                          color: Colors.black,
                                          blurRadius: 7
                                      ),
                                      const Shadow(
                                          color: Colors.black,
                                          blurRadius: 7
                                      ),
                                      const Shadow(
                                          color: Colors.black,
                                          blurRadius: 7
                                      ),
                                      const Shadow(
                                          color: Colors.black,
                                          blurRadius: 7
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: GoogleFonts.abel(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                                fontWeight: FontWeight.w500),
                          ),
                          ZoomTapAnimation(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                            child: Text(
                              "  Create account",
                              style: GoogleFonts.abel(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(.7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

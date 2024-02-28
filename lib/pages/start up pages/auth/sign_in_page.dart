import 'dart:async';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/constant/colors.dart';
import 'package:mywallet/services/auth_service.dart';
import 'package:mywallet/services/database.dart';
import 'package:mywallet/utils/signin_validate.dart';
import 'package:mywallet/services/scroll_behavior.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/upload_image.dart';
import '../../../widgets/auth components/component1.dart';
import '../../../widgets/auth components/component2.dart';
import '../../../widgets/decoration_components/my_painter.dart';
import 'login_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {

  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  bool _isSecurePassword = true;
  bool _isSecurePassword2 = true;

  String avatar = 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';
  String fileId = '';

  Future<List<String>> setImage() async {
    Uint8List img = await pickImage();

    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

    dialog.show(
      message: 'Uploading....',
      type: SimpleFontelicoProgressDialogType.hurricane,
      backgroundColor: Colors.transparent,
      indicatorColor: const Color(0xffc43990),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(.6),
      ),
    );

    String order = DateTime.now().millisecondsSinceEpoch.toString();

    //ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
    //progressDialog.show();
    //upload to Firebase storage
    Reference reference = FirebaseStorage.instance.ref().child(order);
    UploadTask task = reference.putData(img);
    TaskSnapshot snapshot = await task;
    String avatar = await snapshot.ref.getDownloadURL();
    dialog.hide();
    return [avatar, order];
    //progressDialog.dismiss();
  }

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

  Widget togglePassword2() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword2 = !_isSecurePassword2;
        });
      },
      icon: _isSecurePassword2
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

  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController currencyEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  String errorUser = '';
  String errorMail = '';
  String errorType = '';
  String errorPass = '';
  String errorCpass = '';

  final errorValidate = SignInValidate();

  AuthService authService = AuthService();

  var db = Database();

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
                      SizedBox(
                          height: 95,
                          width: 100,
                          child: Stack(
                            children: [
                              ClipOval(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: avatar,
                                      placeholder: (context, url) =>  Shimmer.fromColors(

                                        period: const Duration(milliseconds: 1000),
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: CustomColor.purple[3],
                                                width: 3
                                            ),
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(80),
                                          ),
                                          height: 80,
                                        ),
                                      ), //Image.asset('assets/user.png'),
                                      errorWidget: (context, url,error) => Image.asset('assets/user.png'),
                                    ),
                                  ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () async {

                                      List item = await setImage();

                                      setState(() {

                                        avatar = item[0];
                                        fileId = item[1];

                                      });
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(-2, -2)),
                                      ],
                                      size: 30,
                                    )),
                              )
                            ],
                          )),
                      Component1(context, const Text(''),
                          icon: CupertinoIcons.person_alt,
                          hintText: 'User name',
                          error: errorUser,
                          controller: userNameEditingController),
                      Component1(context, const Text(''),
                          icon: CupertinoIcons.mail_solid,
                          hintText: 'Email address',
                          isEmail: true,
                          error: errorMail,
                          controller: emailEditingController),
                      Component1(context, const Text(''),
                          icon: Iconsax.wallet_money,
                          hintText: 'Currency type - LKR, USD, EUR, INR...',
                          error: errorType,
                          controller: currencyEditingController),
                      Component1(context, togglePassword(),
                          isSecurePass: _isSecurePassword,
                          icon: Iconsax.key,
                          hintText: 'Password',
                          isPassword: true,
                          error: errorPass,
                          controller: passwordEditingController),
                      Component1(context, togglePassword2(),
                          isSecurePass: _isSecurePassword2,
                          icon: Iconsax.key,
                          hintText: 'Confirm password',
                          isPassword: true,
                          error: errorCpass,
                          controller: confirmPasswordEditingController),
                      Component2(
                        context,
                        onTap: () async {
                          String? userName = userNameEditingController.text.capitalize;
                          String email = emailEditingController.text.trim();
                          String? currencyType =
                              currencyEditingController.text.trim();
                          if (currencyType.length == 2) {
                            currencyType = currencyType.capitalize;
                          } else if (currencyType.length == 3) {
                            currencyType = currencyType.toUpperCase();
                          }

                          String password =
                              passwordEditingController.text.trim();
                          String confirmPassword =
                              confirmPasswordEditingController.text.trim();

                          setState(() {
                            errorUser = errorValidate.name(userName!);
                            errorMail = errorValidate.mail(email);
                            errorType = errorValidate.type(currencyType!);
                            errorPass = errorValidate.pass(password);
                            errorCpass =
                                errorValidate.cPass(confirmPassword, password);
                          });

                          if (errorUser == '' &&
                              errorMail == '' &&
                              errorType == '' &&
                              errorPass == '' &&
                              errorCpass == '') {

                            var data = {
                              'username': userName,
                              'email': email,
                              'currency': currencyType,
                              'remainingAmount': 0.0,
                              'budgetAmount': 0.0,
                              'targetAmount': 0.0,
                              'income': 0.0,
                              'expense': 0.0,
                              'totalCredit': 0.0,
                              'totalDebit' : 0.0,
                              'avatar': avatar,
                              'File id' : fileId,
                            };

                            await authService.createUser(data ,password ,context);

                            if(avatar == 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png') {

                              var id = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

                              await FirebaseStorage.instance.ref().child(id['File id']).delete();

                            }

                          }
                          //Get.to(const BalanceAddPage(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 300));
                        },
                        title: 'CREATE',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.abel(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                                fontWeight: FontWeight.w500),
                          ),
                          ZoomTapAnimation(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: Text(
                              "  Login",
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

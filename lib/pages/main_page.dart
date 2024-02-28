import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywallet/constant/bottom_bar.dart';
import 'package:mywallet/constant/colors.dart';

class MainPage extends StatefulWidget {

  static final navigationKey = GlobalKey<CurvedNavigationBarState>();

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;
  var isConnected = false;
  late ConnectivityResult result;
  late StreamSubscription subscription;

  @override
  void initState() {

    super.initState();
    startStreaming();
  }

  checkInternet() async {

    result = await Connectivity().checkConnectivity();

    if(result != ConnectivityResult.none) {


        isConnected = true;


    }else{

      isConnected = false;
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              content: Container(
                height: 50,
                child: Text('!!! Please Check your Network Connection.',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 15,
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    checkInternet();
                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.refresh_thick, color: Colors.black, size: 30,),
                      Text('Retry'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(.6),
                      foregroundColor: Colors.black
                  ),
                ),
              ],

            );
          }
      );

    }

  }

  startStreaming ()
  {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      checkInternet();
    });
  }

  @override
  Widget build(BuildContext context) {

    if (DateTime.now().day == 1 && DateTime.now().hour == 0 && DateTime.now().minute == 0) {
       FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
           .update({
         'income' : 0.0,
         'expense' : 0.0,
       });
    }

    return Container(
      color: CustomColor.purple[2],
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: BottomBarCustom.pages[selectedIndex],
            extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              items: BottomBarCustom.items,
              height: 60,
              index: selectedIndex,
              onTap: (index) => setState(() {
                selectedIndex = index;
              }),
              color: CustomColor.purple[3],
              buttonBackgroundColor: CustomColor.purple[0],
              animationDuration: const Duration(milliseconds: 500),
              key: MainPage.navigationKey,
            ),
          ),
        ),
      ),
    );
  }
}

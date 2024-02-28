import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/colors.dart';

Widget UsernameCard (

    BuildContext context,
    {
      required String userId,
    }

    )

{

  Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

  return StreamBuilder<DocumentSnapshot>(

    stream: _userStream,

    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

      if(snapshot.hasError) {

        return Text('Something went wrong!!!', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.bold),);

      } else if(snapshot.connectionState == ConnectionState.waiting) {

        return Center(child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SpinKitRipple(color: Colors.white.withOpacity(.7),size: 20,),
        ));

      } else if(!snapshot.hasData || !snapshot.data!.exists) {

        return Center(child: Text('Oops!!!, no data found', style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 15,fontWeight: FontWeight.bold),));

      } else if(snapshot.hasData) {

        var data  = snapshot.data!.data() as Map<dynamic, dynamic>;
        String user = data['username'];
        String avatar = data['avatar'];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: ClipOval(
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
              const SizedBox(width: 7,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome,',
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 15
                    ),
                  ),
                  Text(user,
                    style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 18
                    ),
                  ),
                ],
              )

            ],
          ),
        ).animate().slideX(curve: Curves.fastEaseInToSlowEaseOut,duration: const Duration(milliseconds: 1200)).shimmer(delay: const Duration(milliseconds: 1700));

      } else {

        return const Center(child: CircularProgressIndicator(color: Colors.white,),);

      }
    },
  );
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/colors.dart';

class CachedImage extends StatefulWidget {

  final String userId;

  const CachedImage({super.key, required this.userId});

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {

  String avatar = 'http://www.clker.com/cliparts/f/a/0/c/1434020125875430376profile-hi.png';

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance.collection('users').doc(widget.userId).get().then((value){
      setState(() {
        avatar = value['avatar'];
      });
    });

    return CachedNetworkImage(
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
    );

  }
}

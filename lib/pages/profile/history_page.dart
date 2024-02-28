import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywallet/widgets/history%20components/gauge_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../constant/colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  //pick the image
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        title: Text('History',
          style: GoogleFonts.aBeeZee(
              color: Colors.white.withOpacity(.7),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios,color: Colors.white.withOpacity(.7),size: 24,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GaugeData(context, userId: userId),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mywallet/utils/loaner_pic.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../constant/colors.dart';
import 'cached_loaner_pic.dart';

class EditLoaners extends StatefulWidget {

  final String avatar;
  final String name;
  final String phone;
  final String id;

  const EditLoaners({super.key, required this.avatar, required this.id, required this.name, required this.phone});

  @override
  State<EditLoaners> createState() => _EditLoanersState();
}

class _EditLoanersState extends State<EditLoaners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        title: Text('Edit details',
          style: GoogleFonts.aBeeZee(
              color: Colors.white.withOpacity(.7),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios,color: Colors.white.withOpacity(.7),size: 24,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: 30,
              ),


              Center(child: LoanerPic(context, avatar: widget.avatar, size: 80)),

              const SizedBox(height: 10,),

              ZoomTapAnimation(
                  onTap: () => uploadLoanerImage(widget.id),
                  child: Text('Change picture',style: TextStyle(color: CustomColor.purple[0],fontSize: 16),)),

              const SizedBox(height: 3,),

              ZoomTapAnimation(
                  onTap: ()=> setLoanerDefault,
                  child: Text('Set default',style: TextStyle(color: CustomColor.purple[1],fontSize: 16),)),

            ],
          ),
        ),
      ),
    );
  }
}

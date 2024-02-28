import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mywallet/widgets/my%20profile%20component/show_editor.dart';

Widget EditForm(BuildContext context,{required String title, required String formTitle, bool isAmount = true, String currency = ''}) {

  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 15
              ),
            ),
            Row(
              children: [
                Text(formTitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 18
                  ),
                ),

                if(isAmount)
                  Row(
                    children: [
                      const SizedBox(width: 10,),
                      Text(currency,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 15
                        ),
                      ),

                    ],
                  ),

                const Spacer(),

                Icon(CupertinoIcons.pencil,color: Colors.white,),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
      onTap: (){
        Get.to(
            ShowEditor(
              title: title,
              formTitle: formTitle,
              isAmount: isAmount,
              currency: currency,
            ),
            //fullscreenDialog: true,
            popGesture: true
        );
      },
    ),
  );

}
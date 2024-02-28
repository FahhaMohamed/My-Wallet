import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

showCustomProgress(BuildContext context, {String message = 'Loading...', bool isShow = true}) {

  SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);

  if(isShow) {
    dialog.show(
      message: message,
      type: SimpleFontelicoProgressDialogType.hurricane,
      backgroundColor: Colors.transparent,
      indicatorColor: const Color(0xffc43990),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(.6),
      ),
    );
  } else if(!isShow) {
    dialog.hide();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/services/handlers.dart';
import 'package:mywallet/widgets/auth%20components/component1.dart';
import 'package:mywallet/widgets/auth%20components/component2.dart';
import 'package:mywallet/widgets/loan%20components/amount_list.dart';
import 'package:mywallet/widgets/loan%20components/cached_loaner_pic.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../constant/colors.dart';

class ViewLoaner extends StatefulWidget {

  final Map model;


  const ViewLoaner({super.key, required this.model});

  @override
  State<ViewLoaner> createState() => _ViewLoanerState();
}

class _ViewLoanerState extends State<ViewLoaner> {

  var handler = Handlers();

  TextEditingController amountEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  String error = '';
  String itemError = '';
  String amountError = '';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        title: Column(
          children: [
            Text('About ${widget.model['name']}',
              style: GoogleFonts.aBeeZee(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            Text('${widget.model['phone']}',
              style: GoogleFonts.aBeeZee(
                  color: Colors.white.withOpacity(.7),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500),
            ),
          ],
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


              ZoomTapAnimation(
                  onTap: (){

                    showDialog(barrierDismissible: true,context: context, builder: (context) {

                      return Dialog(
                        child: CachedNetworkImage(
                            imageUrl: widget.model['avatar'],
                            placeholder: (context, url)=> CircularProgressIndicator(color: CustomColor.purple[3],),
                        ),
                      );

                    });

                  },
                  child: Center(child: LoanerPic(context, avatar: widget.model['avatar'], size: 90))),

              SizedBox(
                height: 20,
              ),


              Container(
                margin: EdgeInsets.only(bottom: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BALANCE',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 17
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      widget.model['type'] == 'Debtor' ? '${widget.model['totalDebit']} ${widget.model['currency']}':'${widget.model['totalCredit']} ${widget.model['currency']}',
                      style: TextStyle(
                          color: Colors.white.withOpacity(.9),
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),

              if(widget.model['type'] == 'Creditor')
                Container(
                  margin: EdgeInsets.only(bottom: 10,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PAYED',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 17
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        '${widget.model['collect']} ${widget.model['currency']}',
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),

              if(widget.model['type'] == 'Debtor')
                Container(
                  margin: EdgeInsets.only(bottom: 10,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'COLLECTED',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 17
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        '${widget.model['collect']} ${widget.model['currency']}',
                        style: TextStyle(
                            color: Colors.green.shade500,
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),


              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    if(widget.model['type'] == 'Debtor')
                      Component2(context, onTap: (){
                        showCupertinoDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            content: SizedBox(
                                height: 80,
                                child: Component1(context, Text('${widget.model['currency']}'), controller: amountEditingController, icon: Iconsax.coin, hintText: 'Amount',isAmount: true,error: error)),
                            actions: [

                              ElevatedButton(
                                  onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('NO'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.3),
                                  foregroundColor: Colors.black,
                                ),
                              ),

                              ElevatedButton(

                                onPressed: () async {

                                  if(amountEditingController.text.isEmpty) {
                                    setState(() {
                                      error = 'Field Empty';
                                    });
                                  }
                                  if(amountEditingController.text.isNotEmpty) {
                                    setState(() {
                                      error = '';
                                    });
                                  }

                                  if(error == '') {

                                    if(widget.model['totalDebit'] - double.parse(amountEditingController.text.trim()) < 0) {

                                      Fluttertoast.showToast(msg: 'Please, Check the balance');

                                    } else {

                                      SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

                                      dialog.show(
                                        message: 'Adding....',
                                        type: SimpleFontelicoProgressDialogType.hurricane,
                                        backgroundColor: Colors.transparent,
                                        indicatorColor: const Color(0xffc43990),
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(.6),
                                        ),
                                      );

                                      final user = FirebaseAuth.instance.currentUser;
                                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                                      var amount = double.parse(amountEditingController.text.trim());
                                      DateTime date = DateTime.now();

                                      String monthyear = DateFormat('MMM y').format(date);
                                      int day = date.day;

                                      String id = DateTime.now().microsecondsSinceEpoch.toString();

                                      double total = widget.model['totalDebit'] - amount;
                                      double collect = widget.model['collect'] + amount;

                                      widget.model.update('totalDebit', (value) => total);
                                      widget.model.update('collect', (value) => collect);



                                      var data = {

                                        'totalDebit' : total,
                                        'collect' : total == 0.0 ? 0.0 : collect,

                                      };

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .collection('loaners').doc(widget.model['id']).update(data);

                                      var userDoc = await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid).get();

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .update({
                                        'totalDebit' : userDoc['totalDebit'] - amount,
                                        'remainingAmount' : userDoc['remainingAmount'] + amount,
                                      });

                                      double remainingAmount = userDoc['remainingAmount'];
                                      double budgetAmount = userDoc['budgetAmount'];
                                      double targetAmount = userDoc['targetAmount'];
                                      double income = userDoc['income'];
                                      double expense = userDoc['expense'];
                                      String currency = userDoc['currency'];



                                      //transaction
                                      var  dataTrans = {

                                        'id' : id,
                                        'item': 'From ${widget.model['name']}',
                                        'income' : income + amount,
                                        'expense' :expense,
                                        'transactionAmount': amount,
                                        'balanceAmount': remainingAmount + amount,
                                        'timestamp': timestamp,
                                        'monthyear' : monthyear,
                                        'day' : day,
                                        'isIncome':true,
                                        'description': '',
                                        'category' : 'Loan payment',
                                        'currency' : currency,

                                      };
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .collection('transactions')
                                          .doc(id.toString()).set(dataTrans);

                                      //monthyear
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.uid)
                                          .collection('usages')
                                          .doc(monthyear).set({
                                        'income' : income + amount,
                                        'expense' : expense,
                                        'remainingAmount' : remainingAmount + amount,
                                        'budgetAmount' : budgetAmount,
                                        'targetAmount' : targetAmount,
                                        'monthyear' : monthyear,
                                        'currency' : currency,
                                      });

                                      //date
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.uid)
                                          .collection('usages')
                                          .doc(monthyear)
                                          .collection('days')
                                          .doc('$day').set({
                                        'day' : day
                                      });


                                      dialog.hide();

                                      Navigator.pop(context);
                                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const MainPage()));
                                    }



                                  }


                              },

                                child: Text('COLLECT'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.6),
                                  foregroundColor: Colors.black,
                                ),
                              ),

                            ],
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                          );
                        });
                      }, title: 'Collect'),

                    if(widget.model['type'] == 'Creditor')
                      Component2(context, onTap: (){
                        showCupertinoDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            content: SizedBox(
                                height: 80,
                                child: Component1(context, Text('${widget.model['currency']}'), controller: amountEditingController, icon: Iconsax.coin, hintText: 'Amount',isAmount: true,error: error)),
                            actions: [

                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('NO'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.3),
                                  foregroundColor: Colors.black,
                                ),
                              ),

                              ElevatedButton(

                                onPressed: () async {

                                  if(amountEditingController.text.isEmpty) {
                                    setState(() {
                                      error = 'Field Empty';
                                    });
                                  }
                                  if(amountEditingController.text.isNotEmpty) {
                                    setState(() {
                                      error = '';
                                    });
                                  }

                                  if(error == '') {


                                    if(widget.model['totalCredit'] - double.parse(amountEditingController.text.trim()) < 0) {
                                      Fluttertoast.showToast(msg: 'Please, Check the balance');
                                    } else {

                                      SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

                                      dialog.show(
                                        message: 'Paying....',
                                        type: SimpleFontelicoProgressDialogType.hurricane,
                                        backgroundColor: Colors.transparent,
                                        indicatorColor: const Color(0xffc43990),
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(.6),
                                        ),
                                      );




                                      final user = FirebaseAuth.instance.currentUser;
                                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                                      var amount = double.parse(amountEditingController.text.trim());
                                      DateTime date = DateTime.now();

                                      String monthyear = DateFormat('MMM y').format(date);
                                      int day = date.day;

                                      String id = DateTime.now().microsecondsSinceEpoch.toString();

                                      double total = widget.model['totalCredit'] - amount;
                                      double collect = widget.model['collect'] + amount;

                                      widget.model.update('totalCredit', (value) => total);
                                      widget.model.update('collect', (value) => collect);

                                      var userDoc = await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth.instance.currentUser!.uid).get();

                                      double remainingAmount = userDoc['remainingAmount'];

                                      if(remainingAmount - amount >= 0 ) {

                                        var data = {
                                          'totalCredit' : total,
                                          'collect' : total == 0.0 ? 0.0 : collect,
                                        };

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .collection('loaners').doc(widget.model['id']).update(data);



                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .update({
                                          'totalCredit' : userDoc['totalCredit'] - amount,
                                          'remainingAmount' : remainingAmount - amount,
                                        });


                                        double budgetAmount = userDoc['budgetAmount'];
                                        double targetAmount = userDoc['targetAmount'];
                                        double income = userDoc['income'];
                                        double expense = userDoc['expense'];
                                        String currency = userDoc['currency'];

                                        var  dataTrans = {

                                          'id' : id,
                                          'item': widget.model['name'],
                                          'income' : income ,
                                          'expense' : expense + amount ,
                                          'transactionAmount': amount,
                                          'balanceAmount': remainingAmount - amount,
                                          'timestamp': timestamp,
                                          'monthyear' : monthyear,
                                          'day' : day,
                                          'isIncome': false,
                                          'description': '',
                                          'category' : 'Loan payment',
                                          'currency' : currency,

                                        };

                                        //trans
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid)
                                            .collection('transactions')
                                            .doc(id.toString()).set(dataTrans);

                                        //month
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .collection('usages')
                                            .doc(monthyear).set({
                                          'income' : income,
                                          'expense' : expense + amount,
                                          'remainingAmount' : remainingAmount - amount ,
                                          'budgetAmount' : budgetAmount,
                                          'targetAmount' : targetAmount,
                                          'monthyear' : monthyear,
                                          'currency' : currency,
                                        });

                                        //day
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .collection('usages')
                                            .doc(monthyear)
                                            .collection('days')
                                            .doc('$day').set({
                                          'day' : day
                                        });

                                        dialog.hide();
                                        Navigator.pop(context);

                                      }else {

                                        dialog.hide();
                                        ToastService.showErrorToast(context,message: 'Oops!!! Please check your Main Balance');
                                        Navigator.pop(context);
                                      }

                                    }



                                  }


                                },

                                child: Text('PAY'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(.6),
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ],
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                          );
                        });
                      }, title: 'Pay'),

                    if(widget.model['type'] == 'Debtor')
                      Component2(context, onTap: (){

                        amountEditingController.text = '';
                        textEditingController.text = '';

                        showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                content: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Component1(context, Text(''), controller: textEditingController, icon: Icons.edit, hintText: 'Title'),
                                      Component1(context, Text(''), controller: amountEditingController, icon: Iconsax.coin, hintText: 'Amount',isAmount: true,currency: widget.model['currency']),

                                    ],
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(
                                    onPressed: (){Navigator.pop(context);},
                                    child: Text('NO'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white.withOpacity(.3),
                                        foregroundColor: Colors.black
                                    ),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {

                                      String? item = textEditingController.text.capitalize;
                                      String value = amountEditingController.text.trim();

                                      //item
                                      if(item!.isEmpty) {
                                        setState(() {
                                          itemError = 'Title ??';
                                        });
                                        Fluttertoast.showToast(msg: 'Please add Title');
                                      }

                                      if(item.isNotEmpty) {
                                        setState(() {
                                          itemError = '';
                                        });
                                      }

                                      //amount
                                      if(value.isEmpty) {
                                        setState(() {
                                          amountError = 'Amount ??';
                                        });
                                        Fluttertoast.showToast(msg: 'Please add Amount');
                                      }

                                      if(value.isNotEmpty) {
                                        setState(() {
                                          amountError = '';
                                        });
                                      }

                                      if(itemError == '' && amountError == '') {

                                        SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

                                        dialog.show(
                                          message: 'Adding....',
                                          type: SimpleFontelicoProgressDialogType.hurricane,
                                          backgroundColor: Colors.transparent,
                                          indicatorColor: const Color(0xffc43990),
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white.withOpacity(.6),
                                          ),
                                        );

                                        final user = FirebaseAuth.instance.currentUser;
                                        int timestamp = DateTime.now().millisecondsSinceEpoch;
                                        var amount = double.parse(value);

                                        DateTime date = DateTime.now();

                                        String monthyear = DateFormat('MMM y').format(date);
                                        int day = date.day;

                                        String id = DateTime.now().microsecondsSinceEpoch.toString();

                                        double total =  widget.model['totalDebit'] + amount;
                                        widget.model.update('totalDebit', (value) => total);

                                        final userDoc = await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid)
                                            .get();

                                        double remainingAmount = userDoc['remainingAmount'];
                                        double budgetAmount = userDoc['budgetAmount'];
                                        double targetAmount = userDoc['targetAmount'];
                                        double income = userDoc['income'];
                                        double expense = userDoc['expense'];
                                        double totalCredit = userDoc['totalCredit'];
                                        double totalDebit = userDoc['totalDebit'];
                                        String currency = userDoc['currency'];


                                        if(remainingAmount - amount <= 0) {

                                          dialog.hide();

                                          ToastService.showErrorToast(context,message: 'Oops!!! Please check your Main Balance.');

                                        } else {




                                          var dataLoan = {
                                            'id' : id,
                                            'title' : item,
                                            'amount' : amount,
                                            'timestamp' : timestamp,
                                            'total' : total,
                                          };

                                          var dataLoaners = {

                                            'totalDebit' : total,

                                          };

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection('loaners').doc(widget.model['id']).collection('items').doc(id).set(dataLoan);

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection('loaners').doc(widget.model['id']).update(dataLoaners);

                                          var  dataTrans = {

                                            'id' : id,
                                            'item': item,
                                            'income' :income,
                                            'expense' :  expense + amount,
                                            'transactionAmount': amount,
                                            'balanceAmount': remainingAmount - amount,
                                            'timestamp': timestamp,
                                            'monthyear' : monthyear,
                                            'day' : day,
                                            'isIncome': false ,
                                            'description':'To ${widget.model['name']}',
                                            'category' : 'Loan payment',
                                            'currency' : currency,

                                          };

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .update({

                                            'remainingAmount' : remainingAmount - amount,
                                            'income' : income,
                                            'expense' : expense + amount ,
                                            'updatedAt' : timestamp,
                                            'totalCredit' : totalCredit ,
                                            'totalDebit' :totalDebit + amount,

                                          });

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('transactions')
                                              .doc(id.toString()).set(dataTrans);

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('usages')
                                              .doc(monthyear).set({
                                            'income' :  income ,
                                            'expense' :  expense + amount,
                                            'remainingAmount' :  remainingAmount - amount ,
                                            'budgetAmount' : budgetAmount,
                                            'targetAmount' : targetAmount,
                                            'monthyear' : monthyear,
                                            'currency' : currency,
                                          });

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('usages')
                                              .doc(monthyear)
                                              .collection('days')
                                              .doc('$day').set({
                                            'day' : day
                                          });



                                          dialog.hide();
                                          Navigator.pop(context);

                                        }



                                      }

                                    },
                                    child: Text('ADD'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white.withOpacity(.6),
                                        foregroundColor: Colors.black
                                    ),
                                  ),
                                ],

                              );
                            }
                        );

                      }, title: 'Add New +',),

                    if(widget.model['type'] == 'Creditor')
                      Component2(context, onTap: (){

                        amountEditingController.text = '';
                        textEditingController.text = '';

                        showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                content: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Component1(context, Text(''), controller: textEditingController, icon: Icons.edit, hintText: 'Title'),
                                      Component1(context, Text(''), controller: amountEditingController, icon: Iconsax.coin, hintText: 'Amount',isAmount: true,currency: widget.model['currency']),

                                    ],
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(
                                    onPressed: (){Navigator.pop(context);},
                                    child: Text('NO'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white.withOpacity(.3),
                                        foregroundColor: Colors.black
                                    ),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {

                                      String? item = textEditingController.text.capitalize;
                                      String value = amountEditingController.text.trim();

                                      //item
                                      if(item!.isEmpty) {
                                        setState(() {
                                          itemError = 'Title ??';
                                        });
                                        Fluttertoast.showToast(msg: 'Please add Title');
                                      }

                                      if(item.isNotEmpty) {
                                        setState(() {
                                          itemError = '';
                                        });
                                      }

                                      //amount
                                      if(value.isEmpty) {
                                        setState(() {
                                          amountError = 'Amount ??';
                                        });
                                        Fluttertoast.showToast(msg: 'Please add Amount');
                                      }

                                      if(value.isNotEmpty) {
                                        setState(() {
                                          amountError = '';
                                        });
                                      }

                                      if(itemError == '' && amountError == '') {

                                        SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(context: context);

                                        dialog.show(
                                          message: 'Adding....',
                                          type: SimpleFontelicoProgressDialogType.hurricane,
                                          backgroundColor: Colors.transparent,
                                          indicatorColor: const Color(0xffc43990),
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white.withOpacity(.6),
                                          ),
                                        );

                                        final user = FirebaseAuth.instance.currentUser;
                                        int timestamp = DateTime.now().millisecondsSinceEpoch;
                                        var amount = double.parse(value);

                                        DateTime date = DateTime.now();

                                        String monthyear = DateFormat('MMM y').format(date);
                                        int day = date.day;

                                        String id = DateTime.now().microsecondsSinceEpoch.toString();

                                        double total = widget.model['totalCredit'] + amount;

                                        widget.model.update('totalCredit', (value) => total);

                                        final userDoc = await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid)
                                            .get();

                                        double remainingAmount = userDoc['remainingAmount'];
                                        double budgetAmount = userDoc['budgetAmount'];
                                        double targetAmount = userDoc['targetAmount'];
                                        double income = userDoc['income'];
                                        double expense = userDoc['expense'];
                                        double totalCredit = userDoc['totalCredit'];
                                        double totalDebit = userDoc['totalDebit'];
                                        String currency = userDoc['currency'];





                                          var dataLoan = {
                                            'id' : id,
                                            'title' : item,
                                            'amount' : amount,
                                            'timestamp' : timestamp,
                                            'total' : total,
                                          };

                                          var dataLoaners = {

                                            'totalCredit' :  total,

                                          };

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection('loaners').doc(widget.model['id']).collection('items').doc(id).set(dataLoan);

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection('loaners').doc(widget.model['id']).update(dataLoaners);

                                          var  dataTrans = {

                                            'id' : id,
                                            'item': item,
                                            'income' : income + amount,
                                            'expense' : expense,
                                            'transactionAmount': amount,
                                            'balanceAmount': remainingAmount + amount,
                                            'timestamp': timestamp,
                                            'monthyear' : monthyear,
                                            'day' : day,
                                            'isIncome': true,
                                            'description': 'From ${widget.model['name']}',
                                            'category' : 'Loan payment',
                                            'currency' : currency,

                                          };

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .update({

                                            'remainingAmount' : remainingAmount + amount,
                                            'income' : income + amount,
                                            'expense' : expense,
                                            'updatedAt' : timestamp,
                                            'totalCredit' : totalCredit + amount,
                                            'totalDebit' : totalDebit,

                                          });

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('transactions')
                                              .doc(id.toString()).set(dataTrans);

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('usages')
                                              .doc(monthyear).set({
                                            'income' : income + amount,
                                            'expense' :  expense,
                                            'remainingAmount' : remainingAmount + amount,
                                            'budgetAmount' : budgetAmount,
                                            'targetAmount' : targetAmount,
                                            'monthyear' : monthyear,
                                            'currency' : currency,
                                          });

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('usages')
                                              .doc(monthyear)
                                              .collection('days')
                                              .doc('$day').set({
                                            'day' : day
                                          });

                                          dialog.hide();
                                          Navigator.pop(context);



                                      }

                                    },
                                    child: Text('ADD'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white.withOpacity(.6),
                                        foregroundColor: Colors.black
                                    ),
                                  ),
                                ],

                              );
                            }
                        );

                      }, title: 'Add New +',),


                    Component2(context, onTap: (){
                      handler.openWhatsapp(
                        phone: widget.model['phone'],
                      );
                    }, title: 'Message >',),
                  ],
                ),
              ),

              const SizedBox(height: 30,),

              SizedBox(
                height: 600,
                child: AmountList(id: widget.model['id'], currency: widget.model['currency'])
              ),


            ],
          ),
        ),
      ),
    );
  }
}

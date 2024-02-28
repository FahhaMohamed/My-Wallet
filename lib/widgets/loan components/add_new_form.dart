import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/pages/main_page.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toasty_box/toast_service.dart';
import '../../constant/colors.dart';
import '../add_trans_components/custom_button.dart';
import '../add_trans_components/custom_form.dart';

class AddNewForm extends StatefulWidget {

  final Map model;

  const AddNewForm({super.key, required this.model});

  @override
  State<AddNewForm> createState() => _AddNewFormState();
}

class _AddNewFormState extends State<AddNewForm> {

  TextEditingController itemEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  String itemError = '';
  String amountError = '';
  String descriptionError = '';

  bool isOn = false;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: CustomColor.purple[3].withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: CustomColor.purple[3].withOpacity(0.3),
        title: Text('Add New',
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 50,),

                CustomForm(labelText: 'Title', controller: itemEditingController, error: itemError),

                CustomForm(labelText: 'Amount', controller: amountEditingController, isAmount: true, error: amountError, suffix: true, currency: widget.model['currency']),

                const SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: CustomButton(context, onTap: () async {

                    String? item = itemEditingController.text.capitalize;
                    String value = amountEditingController.text.trim();

                    //item
                    if(item!.isEmpty) {
                      setState(() {
                        itemError = 'Title ??';
                      });
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
                    }

                    if(value.isNotEmpty) {
                      setState(() {
                        amountError = '';
                      });
                    }

                    if(itemError == '' && amountError == ''  && descriptionError == '') {

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


                        if(remainingAmount - amount <= 0 && widget.model['type'] == 'Debtor') {

                          dialog.hide();

                          ToastService.showErrorToast(context,message: 'Oops!!! Please check your Main Balance.');

                        } else {

                          double total = widget.model['type'] == 'Debtor' ? widget.model['totalDebit'] + amount : widget.model['totalCredit'] + amount;

                          var dataLoan = {
                            'id' : id,
                            'title' : item,
                            'amount' : amount,
                            'timestamp' : timestamp,
                            'total' : total,
                          };

                          var dataLoaners = {

                            'totalCredit' : widget.model['type'] == 'Debtor' ? widget.model['totalCredit'] : widget.model['totalCredit']  + amount,
                            'totalDebit' : widget.model['type'] == 'Debtor' ? widget.model['totalDebit'] + amount :  widget.model['totalDebit'],

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
                            'income' : widget.model['type'] == 'Debtor' ? income : income + amount,
                            'expense' : widget.model['type'] == 'Debtor' ? expense + amount : expense,
                            'transactionAmount': amount,
                            'balanceAmount': widget.model['type'] == 'Debtor' ?  remainingAmount - amount : remainingAmount + amount,
                            'timestamp': timestamp,
                            'monthyear' : monthyear,
                            'day' : day,
                            'isIncome': widget.model['type'] == 'Debtor' ? false : true,
                            'description': widget.model['type'] == 'Debtor' ? 'To ${widget.model['name']}' : 'From ${widget.model['name']}',
                            'category' : 'Loan payment',
                            'currency' : currency,

                          };

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .update({

                            'remainingAmount' : widget.model['type'] == 'Debtor' ?  remainingAmount - amount : remainingAmount + amount,
                            'income' : widget.model['type'] == 'Debtor' ? income : income + amount,
                            'expense' : widget.model['type'] == 'Debtor' ? expense + amount : expense,
                            'updatedAt' : timestamp,
                            'totalCredit' : widget.model['type'] == 'Debtor' ? totalCredit : totalCredit + amount,
                            'totalDebit' : widget.model['type'] == 'Debtor' ? totalDebit + amount : totalDebit,

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
                            'income' : widget.model['type'] == 'Debtor' ? income : income + amount,
                            'expense' :  widget.model['type'] == 'Debtor' ? expense + amount : expense,
                            'remainingAmount' : widget.model['type'] == 'Debtor' ?  remainingAmount - amount : remainingAmount + amount,
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const MainPage()));

                        }



                    }

                  }, title: 'Add'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

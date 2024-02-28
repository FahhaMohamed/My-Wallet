import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/constant/colors.dart';
import 'package:mywallet/pages/main_page.dart';
import 'package:mywallet/widgets/decoration_components/background.dart';
import 'package:mywallet/widgets/add_trans_components/custom_radio.dart';
import 'package:mywallet/widgets/add_trans_components/custom_switch.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:uuid/uuid.dart';
import '../constant/categories.dart';
import '../widgets/add_trans_components/custom_button.dart';
import '../widgets/add_trans_components/custom_form.dart';

class AddTransPage extends StatefulWidget {
  const AddTransPage({super.key});

  @override
  State<AddTransPage> createState() => _AddTransPageState();
}

class _AddTransPageState extends State<AddTransPage> {

  TextEditingController itemEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  String itemError = '';
  String amountError = '';
  String descriptionError = '';

  var uid = Uuid();


  //For radio
  String groupValue = 'Income';

  //For Switch (description)
  bool isOn = false;


  String? selectedItem = 'Choose category';
  String dropDownError = '';
  bool isAddNew = false;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Background(
            context,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Image.asset('assets/coins.png',width: 35,filterQuality: FilterQuality.high,color: Colors.white.withOpacity(.7),),

                          const SizedBox(width: 15,),

                          Text('Add New Transaction',
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 40,),

                      Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0,),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(.7),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),

                            CustomForm(labelText: 'Title', error: itemError, controller: itemEditingController).animate().shimmer(delay: const Duration(milliseconds: 1600)),

                            const SizedBox(height: 10,),

                            CustomForm(
                              labelText: 'Amount',
                              suffix: true,
                              currency: 'LKR',
                              error: amountError,
                              controller: amountEditingController,
                              isAmount: true,
                            ).animate().shimmer(delay: const Duration(milliseconds: 1600)),

                            const SizedBox(height: 20,),

                            CustomRadio(
                              groupValue: groupValue,
                              onChanged: (value){
                                setState(() {
                                  groupValue = value;
                                });
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 35.0, right: 35),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                padding: const EdgeInsets.all(0),
                                hint: const Text('Choose'),
                                value: selectedItem,
                                items: itemList.map((index) {

                                  return DropdownMenuItem(
                                      value: index['item'],
                                      child: index['item'] == 'Choose category'
                                          ? Text(index['item'],
                                        style: const TextStyle(
                                          color: Color.fromARGB(200, 255, 0, 183),
                                          fontSize:19,
                                        ),
                                      )
                                          : Row(
                                            children: [
                                              Icon(index['icon'],color: Colors.white.withOpacity(.7),size: 20,),
                                              const SizedBox(width: 15,),
                                              Text(index['item'],style: TextStyle(color: Colors.white.withOpacity(.7),fontSize: 17),),
                                            ],
                                          )
                                  );

                                } ).toList(),
                                onChanged: (value) {
                                  if(value != null) {
                                    setState(() {
                                      selectedItem = value as String;
                                    });
                                  }
                                },
                                dropdownColor: Colors.black,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: selectedItem == 'Choose category' ? CustomColor.purple[0] : const Color.fromARGB(255, 255, 0, 183),
                                          width: 3
                                      )
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: CustomColor.purple[0],
                                          width: 3
                                      )
                                  ),
                                  error: dropDownError == 'Choose category' ? Text(
                                    'Please choose the category',
                                    style: TextStyle(
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                            blurRadius: 3,
                                          )
                                        ],
                                        color: Colors.pink.withOpacity(.6),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ) : null,
                                ),
                              ).animate().shimmer(delay: const Duration(milliseconds: 1600)),
                            ),

                            const SizedBox(height: 20,),

                            CustomSwich(
                              title: 'Small description',
                              isOn: isOn,
                              onChanged: (value) {

                                setState(() {
                                  isOn = value;
                                });

                              },
                            ),

                            if(isOn)
                              CustomForm(

                                labelText: '',
                                isDescription: true,
                                error: descriptionError,
                                controller: descriptionEditingController,

                              ),

                            const SizedBox(height: 50,),

                            CustomButton(
                              context,
                              onTap: () async {


                                int dev = 1;

                                print((1000.0.round()).toString().length);



                                print(1000/dev);

                                String? item = itemEditingController.text.capitalize;
                                String value = amountEditingController.text.trim();
                                String? description = descriptionEditingController.text.capitalize;




                                //new category
                                if(selectedItem == 'Choose category') {
                                  setState(() {
                                    dropDownError = 'Choose category';
                                  });
                                }

                                if(selectedItem != 'Choose category') {
                                  setState(() {
                                    dropDownError = '';
                                  });
                                }

                                //description
                                if(isOn) {

                                  if(description!.isEmpty) {

                                    setState(() {
                                      descriptionError = 'Please enter the description';
                                    });

                                  } else if(description.isNotEmpty) {

                                    setState(() {
                                      descriptionError = '';
                                    });

                                  }

                                }

                                if(!isOn) {

                                  setState(() {
                                    descriptionError = '';
                                  });

                                }

                                //item
                                if(item!.isEmpty) {
                                  setState(() {
                                    itemError = 'Please enter the Title';
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
                                    amountError = 'Please enter the amount';
                                  });
                                }

                                if(value.isNotEmpty) {
                                  setState(() {
                                    amountError = '';
                                  });
                                }

                                //add transaction
                                if(itemError == '' && amountError == ''  && descriptionError == '' && selectedItem != 'Choose category') {

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

                                  //initializations
                                  final user = FirebaseAuth.instance.currentUser;
                                  int timestamp = DateTime.now().millisecondsSinceEpoch;
                                  var amount = double.parse(value);
                                  DateTime date = DateTime.now();

                                  String id = DateTime.now().microsecondsSinceEpoch.toString();

                                  print(id);
                                  String monthyear = DateFormat('MMM y').format(date);
                                  int day = date.day;

                                  final userDoc = await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .get();

                                  double remainingAmount = userDoc['remainingAmount'];
                                  double budgetAmount = userDoc['budgetAmount'];
                                  double targetAmount = userDoc['targetAmount'];
                                  double income = userDoc['income'];
                                  double expense = userDoc['expense'];
                                  String currency = userDoc['currency'];



                                  if(groupValue == 'Income') {

                                    remainingAmount = remainingAmount + amount;
                                    income = income  + amount;

                                  } else {

                                    remainingAmount = remainingAmount - amount;
                                    expense = expense + amount;

                                  }

                                  if(remainingAmount < 0) {

                                    dialog.hide();

                                     ToastService.showErrorToast(context,message: 'Oops!!! Insufficient Balance, please add the Balance.');

                                  }

                                  if(remainingAmount >= 0) {


                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .update({

                                      'remainingAmount' : remainingAmount,
                                      'income' : income,
                                      'expense' : expense,
                                      'updatedAt' : timestamp,

                                    });

                                    var data = {

                                      'id' : id,
                                      'item': item,
                                      'income' : income,
                                      'expense' : expense,
                                      'transactionAmount': amount,
                                      'balanceAmount': remainingAmount,
                                      'timestamp': timestamp,
                                      'monthyear' : monthyear,
                                      'day' : day,
                                      'isIncome': groupValue == 'Income' ? true : false,
                                      'description': '',
                                      'category' : selectedItem,
                                      'currency' : currency,

                                    };

                                    if(isOn) {
                                      setState(() {
                                        data = {

                                          'id' : id,
                                          'item': item,
                                          'income' : income,
                                          'expense' : expense,
                                          'transactionAmount': amount,
                                          'balanceAmount': remainingAmount,
                                          'timestamp': timestamp,
                                          'monthyear' : monthyear,
                                          'day' : day,
                                          'isIncome': groupValue == 'Income' ? true : false,
                                          'description': description,
                                          'category' : selectedItem,
                                          'currency' : currency,

                                        };
                                      });
                                    }

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .collection('transactions')
                                        .doc(id.toString()).set(data);

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .collection('usages')
                                        .doc(monthyear).set({
                                      'income' : income,
                                      'expense' : expense,
                                      'remainingAmount' : remainingAmount,
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



                                    print('All are OK');

                                    dialog.hide();

                                    if(remainingAmount == 0) {

                                      ToastService.showWarningToast(context,message: 'Your Current Balance 0, please add the Balance.');

                                    }

                                    MainPage.navigationKey.currentState?.setPage(0);

                                  }

                                }

                              },
                              title: 'Add transaction',
                            ).animate().shimmer(delay: const Duration(milliseconds: 1600)),

                            const SizedBox(height: 50,),
                          ],
                        ),
                      ).animate().scale(curve: Curves.bounceOut, duration: const Duration(milliseconds: 1300)),

                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  //Icon picker

 /* pickNewIcon() async {

    IconData? iconData = await FlutterIconPicker.showIconPicker(context, iconPackModes: [IconPack.cupertino]);

    if(iconData != null) {

      setState(() {
        _icon = iconData;
      });

    }
  }*/

}

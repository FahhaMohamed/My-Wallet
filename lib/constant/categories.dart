
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconsax/iconsax.dart';

List<String> items = [
  'Choose category',
  'Food',
  'Transportation',
  'Healthcare',
  'Education',
  'Phone payment',
  'Bill payment',
  'Loan payment',
  'Clothing',
  'Stationary',
  'Vehicle',
  'Fee',
  'Water',
  'Electricity',
  'Entertainment',
  'Grocery',
  'Rent',
  'Money',
  'Others',
];

Map<String, dynamic>iconList ={

  'Food' : Icons.fastfood_rounded,
  'Transportation' : Icons.emoji_transportation,
  'Healthcare' : Icons.medical_services,
  'Education' : Icons.school,
  'Phone payment' : Icons.phone_iphone,
  'Bill payment' : Icons.payments_outlined,
  'Loan payment' : CupertinoIcons.creditcard,
  'Clothing' : Icons.shopping_bag,
  'Stationary' : Icons.card_giftcard_rounded,
  'Vehicle' : Icons.car_repair_sharp,
  'Fee' : Icons.monetization_on_outlined,
  'Water' : Icons.water_drop,
  'Electricity' : Icons.electric_bolt,
  'Entertainment' : CupertinoIcons.game_controller_solid,
  'Grocery' : CupertinoIcons.bag,
  'Rent' : Icons.home_filled,
  'Money' : Icons.money,
  'Others' : CupertinoIcons.cart_fill,

};

List<Map<String, dynamic>> itemList = [

{'item' : 'Choose category',  'icon' : Icons.category},
{'item' : 'Food', 'icon' : Icons.fastfood_rounded,},
{'item' : 'Transportation', 'icon' : Icons.emoji_transportation,},
{'item' : 'Healthcare', 'icon' : Icons.medical_services,},
{'item' : 'Education', 'icon' : Icons.school,},
{'item' : 'Phone payment', 'icon' : Icons.phone_iphone,},
{'item' : 'Bill payment', 'icon' : Icons.payments_outlined,},
{'item' : 'Loan payment', 'icon' : CupertinoIcons.creditcard,},
{'item' : 'Clothing', 'icon' : Icons.shopping_bag,},
{'item' : 'Stationary', 'icon' : Icons.card_giftcard_rounded,},
{'item' : 'Vehicle', 'icon' : Icons.car_repair_sharp,},
{'item' : 'Fee', 'icon' : Icons.monetization_on_outlined,},
{'item' : 'Water', 'icon' : Icons.water_drop,},
{'item' : 'Electricity', 'icon' : Icons.electric_bolt,},
{'item' : 'Entertainment', 'icon' : CupertinoIcons.game_controller_solid,},
{'item' : 'Grocery', 'icon' : CupertinoIcons.bag,},
{'item' : 'Rent', 'icon' : Icons.home_filled,},
{'item' : 'Money', 'icon' : Icons.money,},
{'item' : 'Others', 'icon' : CupertinoIcons.cart_fill,},

];

List<Map<String, dynamic>> categoryList = [

{'item': 'All', 'icon': CupertinoIcons.cart_fill_badge_plus},
{'item' : 'Food', 'icon' : Icons.fastfood_rounded,},
{'item' : 'Transportation', 'icon' : Icons.emoji_transportation,},
{'item' : 'Healthcare', 'icon' : Icons.medical_services,},
{'item' : 'Education', 'icon' : Icons.school,},
{'item' : 'Phone payment', 'icon' : Icons.phone_iphone,},
{'item' : 'Bill payment', 'icon' : Icons.payments_outlined,},
{'item' : 'Loan payment', 'icon' : CupertinoIcons.creditcard,},
{'item' : 'Clothing', 'icon' : Icons.shopping_bag,},
{'item' : 'Stationary', 'icon' : Icons.card_giftcard_rounded,},
{'item' : 'Vehicle', 'icon' : Icons.car_repair_sharp,},
{'item' : 'Fee', 'icon' : Icons.monetization_on_outlined,},
{'item' : 'Water', 'icon' : Icons.water_drop,},
{'item' : 'Electricity', 'icon' : Icons.electric_bolt,},
{'item' : 'Entertainment', 'icon' : CupertinoIcons.game_controller_solid,},
{'item' : 'Grocery', 'icon' : CupertinoIcons.bag,},
{'item' : 'Rent', 'icon' : Icons.home_filled,},
{'item' : 'Money', 'icon' : Icons.money,},
{'item' : 'Others', 'icon' : CupertinoIcons.cart_fill,},

];

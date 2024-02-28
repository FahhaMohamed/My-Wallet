import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mywallet/pages/add_trans_page.dart';
import 'package:mywallet/pages/loan_page.dart';
import 'package:mywallet/pages/profile_page.dart';

import '../pages/home_page.dart';
import '../pages/expansive_page.dart';

class BottomBarCustom {
  static final List<dynamic> pages = [
    const HomePage(),
    const TransactionPage(),
    const AddTransPage(),
    const LoanPage(),
    const ProfilePage(),
  ];

  static final List<Widget> items = [
    const Icon(
      IconlyBold.wallet,
      size: 30,
    ),
    const Icon(
      IconlyBold.category,
      size: 30,
    ),
    Icon(
      CupertinoIcons.add_circled_solid,
      size: 30,
    ),
    Icon(
      IconlyBold.user3,
      size: 30,
    ),
    const Icon(
      IconlyBold.profile,
      size: 30,
    )
  ];
}

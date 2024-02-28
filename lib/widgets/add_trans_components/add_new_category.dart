import 'package:flutter/material.dart';

import 'custom_form.dart';

class AddNewCategory extends StatefulWidget {

  final TextEditingController controller;
  final String error;
  const AddNewCategory({super.key, required this.controller, required this.error});

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          )
      ),
      child: Column(
        children: [

          const SizedBox(height: 10,),

          CustomForm(
            isDescription: true,
            labelText: 'Category name',
            controller: widget.controller,
            error: widget.error,
          ),


        ],
      ),
    );
  }
}

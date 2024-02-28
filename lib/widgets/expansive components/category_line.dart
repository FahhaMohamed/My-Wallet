import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mywallet/constant/categories.dart';
import 'package:mywallet/constant/colors.dart';

class CategoryLine extends StatefulWidget {

  final ValueChanged<String?> onChanged;

  const CategoryLine({super.key, required this.onChanged});

  @override
  State<CategoryLine> createState() => _CategoryLineState();
}

class _CategoryLineState extends State<CategoryLine> {

  String currentCategory = 'All';


  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 40,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {

          var data = categoryList[index];

          var item = data['item'];
          var icon = data['icon'];

          return GestureDetector(
            onTap: (){
              setState(() {
                currentCategory = item;
                widget.onChanged(item);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10,right: 10),
              padding: const EdgeInsets.only(left: 15,right: 15),
              decoration: currentCategory == item
                  ? BoxDecoration(
                color: CustomColor.purple[0],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CustomColor.purple[0],width: 2)
              )
                  : BoxDecoration(
                  color:Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CustomColor.purple[0],width: 2)
              ),
              child: Center(
                  child: Row(
                    children: [
                      Icon(icon,
                        size: currentCategory == item ? 25 : 24,
                        color: currentCategory == item ? Colors.black : Colors.white.withOpacity(.7),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                          item,
                        style: currentCategory == item ? const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                        ) : TextStyle(
                            color: Colors.white.withOpacity(.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),),
            ),
          );

        },

      ),

    );

  }
}

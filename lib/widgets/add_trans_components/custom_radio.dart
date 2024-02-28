
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomRadio extends StatefulWidget {

  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadio({super.key, required this.groupValue, required this.onChanged,});

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {

  void _handleChanged(String? value) {
    widget.onChanged?.call(value!);
  }

  void Function(String? value)? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio(
                activeColor: const Color.fromARGB(255, 255, 0, 183),
                value: 'Income',
                groupValue: widget.groupValue,
                onChanged: onChanged,
            ),
            Text('Income',
              style: TextStyle(
                color: widget.groupValue == 'Income' ? const Color.fromARGB(255, 255, 0, 183) : Colors.grey.shade700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20,),
        Row(
          children: [
            Radio(
                activeColor: const Color.fromARGB(255, 255, 0, 183),
                value: 'Expense',
                groupValue: widget.groupValue,
                onChanged: onChanged,
            ),
            Text('Expense',
              style: TextStyle(
                color: widget.groupValue == 'Expense' ? const Color.fromARGB(255, 255, 0, 183) : Colors.grey.shade700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  const CustomTextField({Key? key, required this.hint, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: textEditingController,
      decoration: InputDecoration(

        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        hintText: hint,
      ),
    );
  }
}

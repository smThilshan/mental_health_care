import 'package:flutter/material.dart';

class ChatsSearchField extends StatefulWidget {
  const ChatsSearchField({Key? key}) : super(key: key);

  @override
  State<ChatsSearchField> createState() => _ChatsSearchFieldState();
}

class _ChatsSearchFieldState extends State<ChatsSearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffece6e6),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none, // Remove default border
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

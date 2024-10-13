import 'package:flutter/material.dart';

class BottomNavigationIcon extends StatelessWidget {
  final IconData icon;
  final bool onSelected;
  final VoidCallback onClicked;

  const BottomNavigationIcon(
      {Key? key,
      required this.icon,
      required this.onSelected,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: onSelected ? Color(0xff8c72e0):Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: IconButton(
          icon: Icon(
            icon,
            color: onSelected ? Colors.white:Colors.black,
          ),
          color: Colors.white,
          onPressed: () {
            onClicked();
          },
        ),
      ),
    );
  }
}

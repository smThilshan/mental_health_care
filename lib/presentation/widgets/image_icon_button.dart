import 'package:flutter/material.dart';

class ImageIconButton extends StatelessWidget {
  final String imagePath;
  const ImageIconButton({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffceb1f6),
        borderRadius: BorderRadius.circular(30),
      ),
      width: 50,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}

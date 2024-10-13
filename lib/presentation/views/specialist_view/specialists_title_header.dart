import 'package:flutter/material.dart';

class SpecialistsTitleHeader extends StatelessWidget {
  const SpecialistsTitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('Psychologists',
              style: TextStyle(
                color: Colors.black,
                fontWeight:FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,)),
          ],
        ),
      );
  }
}

import 'package:flutter/material.dart';

class ConsultationsTitleHeader extends StatefulWidget {
  const ConsultationsTitleHeader({Key? key}) : super(key: key);

  @override
  State<ConsultationsTitleHeader> createState() => _ConsultationsTitleHeaderState();
}

class _ConsultationsTitleHeaderState extends State<ConsultationsTitleHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: const <Widget>[
          Text('Consultations',
            style: TextStyle(
              color: Colors.black,
              fontWeight:FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Spacer(),
          // IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,)),
        ],
      ),
    );;
  }
}

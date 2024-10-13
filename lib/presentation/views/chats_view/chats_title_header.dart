import 'package:flutter/material.dart';

class ChatsTitleHeader extends StatelessWidget {
  const ChatsTitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text('Chats',
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
    );
  }
}

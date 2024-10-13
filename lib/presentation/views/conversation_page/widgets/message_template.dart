import 'package:flutter/material.dart';

class MessageTemplate extends StatelessWidget {
  final bool isCurrentUser;
  final String body;
  final String time;
  final VoidCallback onDeleteClick;
  const MessageTemplate({Key? key, required this.isCurrentUser, required this.body, required this.time, required this.onDeleteClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isCurrentUser);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Padding(
        padding: isCurrentUser?EdgeInsets.only(left: 80):EdgeInsets.only(right: 80),
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser?Color(0xffe5d9fa):Color(0xfffaeaf9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(body),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.done_all,color: Colors.green,size: 13,),
                    Text(time,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    ),
                    IconButton(onPressed: (){
                      onDeleteClick();
                    }, icon: Icon(Icons.delete,color: Colors.grey,)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

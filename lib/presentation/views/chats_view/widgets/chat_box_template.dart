import 'package:flutter/material.dart';

class ChatBoxTemplate extends StatefulWidget {
  final String displayeName;
  final String special;
  final VoidCallback onTapped;
  final String gender;
  const ChatBoxTemplate({Key? key, required this.displayeName, required this.special, required this.onTapped, required this.gender}) : super(key: key);

  @override
  State<ChatBoxTemplate> createState() => _ChatBoxTemplateState();
}

class _ChatBoxTemplateState extends State<ChatBoxTemplate> {
  bool? isMan;

  @override
  void initState() {
    super.initState();
    setGenderValue();
  }

  setGenderValue(){
    if(widget.gender=='male'){
      setState(() {
        isMan=true;
        isMan=isMan;
      });
    }
    else if(widget.gender=='female'){
      setState(() {
        isMan=false;
        isMan=isMan;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        widget.onTapped();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.deepPurple,
                      backgroundImage:isMan!? AssetImage('assets/images/doctor_man.jpg'):AssetImage('assets/images/doctor_girl.jpg'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          widget.displayeName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '26.01',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.special,
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tap to view messages...',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '5',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}

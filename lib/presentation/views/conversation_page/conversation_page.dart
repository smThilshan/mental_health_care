import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/views/conversation_page/widgets/conversation_messages.dart';

class ConversationPage extends StatefulWidget {
  final String endUserId;
  final String currentUserId;
  final String endUserName;

  const ConversationPage(
      {Key? key,
      required this.endUserId,
      required this.currentUserId,
      required this.endUserName})
      : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController messageTxtController = TextEditingController();
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              widget.endUserName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'online',
                              style: TextStyle(
                                  color: Color(0xff79cd41),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            Expanded(
                child: ConversationMessages(
                  currentUserId: widget.currentUserId,
                  endUserId: widget.endUserId,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
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
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: messageTxtController,
                                decoration: InputDecoration(
                                  hintText: "Message...",
                                  border:
                                      InputBorder.none, // Remove default border
                                ),
                              ),
                            ),
                            IconButton(onPressed: ()async{

                              if (messageTxtController.text.isNotEmpty) {
                                print(widget.currentUserId);
                                print(widget.endUserId);
                                String txt=messageTxtController.text;
                                messageTxtController.clear();
                                firebaseFeatures.writeMessageForCurrentUser(txt, widget.currentUserId, widget.endUserId);
                                firebaseFeatures.writeMessageForEndUser(txt, widget.currentUserId, widget.endUserId);
                              // await firebaseFeatures.writeMessageToFirestore(txt, widget.currentUserId, widget.endUserId);
                              }
                            }, icon: Icon(Icons.send,color: Colors.black,),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

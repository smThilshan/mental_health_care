import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/presentation/views/chats_view/widgets/chat_box_template.dart';
import 'package:mental_health/presentation/views/conversation_page/conversation_page.dart';
import 'package:mental_health/presentation/views/doctor_chats_page/widgets/chat_box_template.dart';

import '../../../data/models/user_model.dart';

class DoctorChatList extends StatefulWidget {
  final List<UserModel> userList;
  final User user;

  const DoctorChatList({Key? key, required this.userList, required this.user})
      : super(key: key);

  @override
  State<DoctorChatList> createState() => _DoctorChatListState();
}

class _DoctorChatListState extends State<DoctorChatList> {



  @override
  void initState() {
    // TODO: implement initState
    print(widget.userList);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: widget.userList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ConversationPage(
                              endUserId: widget.userList[index].uid.toString(),
                              currentUserId: widget.user.uid,
                              endUserName: widget.userList[index].displayName
                                  .toString()),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: DoctorChatBoxTemplate(
                  gender: widget.userList[index].gender.toString(),
                  displayName: widget.userList[index].displayName.toString(),
                ),
              );
            }));
  }
}

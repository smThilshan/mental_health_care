import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bloc/public_chats/public_chats_bloc.dart';
import 'package:mental_health/presentation/bloc/public_chats/public_chats_bloc.dart';
import 'package:mental_health/presentation/views/chats_view/widgets/chat_box_template.dart';
import 'package:mental_health/presentation/views/conversation_page/conversation_page.dart';
import 'package:mental_health/presentation/views/doctor_chats_page/widgets/chat_box_template.dart';

class ChatsList extends StatefulWidget {
  final String currentUserId;

  const ChatsList({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<PublicChatsBloc>(context)
        .add(GetPublicChatsEvent(currentUserId: widget.currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<PublicChatsBloc, PublicChatsState>(
        builder: (context, state) {
          if (state is PublicChatsChatsLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Colors.deepPurple,
                    backgroundColor: Colors.pink,
                  ),
                ],
              ),
            );
          } else if (state is PublicChatsLoaded) {
            return ListView.builder(
                itemCount: state.doctorList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatBoxTemplate(
                    gender: state.doctorList[index].gender.toString(),
                    onTapped: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              ConversationPage(
                                  endUserId:
                                      state.doctorList[index].uid.toString(),
                                  currentUserId: widget.currentUserId,
                                  endUserName: state.doctorList[index].displayName.toString()),
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
                    special: state.doctorList[index].special.toString(),
                    displayeName:
                        state.doctorList[index].displayName.toString(),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
    );

  }
}

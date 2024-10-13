import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/views/doctor_chats_page/doctor_chat_list.dart';

import '../../bloc/doctor_chats/doctor_chats_bloc.dart';

class DoctorChatsPage extends StatefulWidget {
  final User user;

  const DoctorChatsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DoctorChatsPage> createState() => _DoctorChatsPageState();
}

class _DoctorChatsPageState extends State<DoctorChatsPage> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<DoctorChatsBloc>(context).add(GetChatsEvent(currentUserId: widget.user.uid));
    print(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Chats',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: BlocBuilder<DoctorChatsBloc, DoctorChatsState>(
        builder: (context, state) {
          if (state is DoctorChatsLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                  color: Colors.deepPurple,
              ),
                ],
              ),
            );
          }

          else if(state is DoctorChatsLoaded){
          return Column(
          children: <Widget>[
          DoctorChatList(userList: state.userList,user: widget.user),
          ],
          );
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mental_health/data/data_sources/firebase_firestore.dart';
import 'package:mental_health/data/models/message_model.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/views/conversation_page/widgets/message_template.dart';

class ConversationMessages extends StatefulWidget {
  final String currentUserId;
  final String endUserId;

  const ConversationMessages({
    Key? key,
    required this.currentUserId,
    required this.endUserId,
  }) : super(key: key);

  @override
  State<ConversationMessages> createState() => _ConversationMessagesState();
}

class _ConversationMessagesState extends State<ConversationMessages> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the ScrollController when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFeatures firebaseFeatures = FirebaseFeatures();

    return StreamBuilder<List<MessageModel>>(
      stream: FirestoreDataSource().getMessageModelStream(widget.currentUserId, widget.endUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<MessageModel> messageModels = snapshot.data ?? [];

        // Automatically scroll to the bottom of the list when new data is received
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });

        return ListView.builder(
          controller: _scrollController,
          reverse: false, // This makes the ListView start from the bottom
          itemCount: messageModels.length,
          itemBuilder: (context, index) {
            final messageModel = messageModels[index];
            bool isCurrentUser = messageModel.userId == widget.currentUserId;
            // print(messageModel.userId);
            // print(widget.currentUserId);

            return MessageTemplate(
              onDeleteClick: () async {
                await firebaseFeatures.deleteMessageForCurrentUser(
                  widget.currentUserId,
                  widget.endUserId,
                  messageModel.messageId.toString(),
                );
              },
              body: messageModel.body ?? "",
              time: messageModel.time != null
                  ? '${messageModel.time!.hour.toString().padLeft(2, '0')}:${messageModel.time!.minute.toString().padLeft(2, '0')}'
                  : '',
              isCurrentUser: isCurrentUser,
            );
          },
        );
      },
    );
  }
}

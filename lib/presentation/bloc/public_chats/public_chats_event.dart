part of 'public_chats_bloc.dart';

@immutable
abstract class PublicChatsEvent {}

class GetPublicChatsEvent extends PublicChatsEvent{
  final String currentUserId;
  GetPublicChatsEvent({required this.currentUserId});
}

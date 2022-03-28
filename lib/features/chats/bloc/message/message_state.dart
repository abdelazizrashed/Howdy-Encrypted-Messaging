part of 'message_bloc.dart';

abstract class MessageState {
  const MessageState();
}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageModel> messages;

  MessageLoaded(this.messages);
}

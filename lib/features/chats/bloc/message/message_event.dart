part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessageEvent {
  final String friendUid;
  const GetMessagesEvent(this.friendUid);

  @override
  List<Object> get props => [friendUid];
}

class SendMessagesEvent extends MessageEvent {
  final MessageModel message;
  const SendMessagesEvent(this.message);

  @override
  List<Object> get props => [message];
}

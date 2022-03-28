import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:howdy/features/chats/models/message_model.dart';
import 'package:howdy/features/chats/services/message_services.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageServices messageServices = MessageServices();
  MessageBloc() : super(MessageLoading()) {
    on<GetMessagesEvent>(_onGetMessagesEvent);
    on<SendMessagesEvent>(_onSendMessagesEvent);
  }

  Future<FutureOr<void>> _onGetMessagesEvent(
      GetMessagesEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    var messagesStream =
        await messageServices.getMessagesStream(event.friendUid);

    await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(messagesStream,
        onData: (QuerySnapshot<Map<String, dynamic>> data) {
      List<MessageModel> messages = [];
      for (var doc in data.docs) {
        messages.add(MessageModel.fromJson(doc.data()));
      }
      messages.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));
      return MessageLoaded(messages);
    });
  }

  Future<FutureOr<void>> _onSendMessagesEvent(
      SendMessagesEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    await messageServices.sendMessage(event.message);
  }
}

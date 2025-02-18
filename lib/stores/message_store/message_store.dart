import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

enum MessageType { success, error, info, warning }

class Message {
  final String id;
  final MessageType type;
  final String message;
  final String? description;

  Message({
    String? id,
    required this.type,
    required this.message,
    this.description,
  }) : id = id ?? Uuid().v4();
}

abstract class _MessageStore with Store {
  static const int MAX_MESSAGES = 5;

  @observable
  ObservableList<Message> messages = ObservableList<Message>();

  @action
  void addMessage(MessageType type, String message, {String? description}) {
    if (messages.length >= MAX_MESSAGES) {
      messages.removeAt(0);
    }
    messages
        .add(Message(type: type, message: message, description: description));
  }

  @action
  void removeMessage(String id) {
    messages.removeWhere((msg) => msg.id == id);
  }

  @action
  void clearAllMessages() {
    messages.clear();
  }

  @action
  void showMessage(MessageType type, String message, {String? description}) {
    addMessage(type, message, description: description);
  }
}

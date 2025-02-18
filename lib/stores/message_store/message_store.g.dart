// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  late final _$messagesAtom =
      Atom(name: '_MessageStore.messages', context: context);

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

  @override
  void addMessage(MessageType type, String message, {String? description}) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.addMessage');
    try {
      return super.addMessage(type, message, description: description);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeMessage(String id) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.removeMessage');
    try {
      return super.removeMessage(id);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllMessages() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.clearAllMessages');
    try {
      return super.clearAllMessages();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showMessage(MessageType type, String message, {String? description}) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.showMessage');
    try {
      return super.showMessage(type, message, description: description);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messages: ${messages}
    ''';
  }
}

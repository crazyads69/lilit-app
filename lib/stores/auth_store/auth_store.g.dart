// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$deviceIdAtom =
      Atom(name: '_AuthStore.deviceId', context: context);

  @override
  String? get deviceId {
    _$deviceIdAtom.reportRead();
    return super.deviceId;
  }

  @override
  set deviceId(String? value) {
    _$deviceIdAtom.reportWrite(value, super.deviceId, () {
      super.deviceId = value;
    });
  }

  late final _$userAtom = Atom(name: '_AuthStore.user', context: context);

  @override
  AuthData? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(AuthData? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$accessTokenAtom =
      Atom(name: '_AuthStore.accessToken', context: context);

  @override
  String? get accessToken {
    _$accessTokenAtom.reportRead();
    return super.accessToken;
  }

  @override
  set accessToken(String? value) {
    _$accessTokenAtom.reportWrite(value, super.accessToken, () {
      super.accessToken = value;
    });
  }

  late final _$refreshTokenAtom =
      Atom(name: '_AuthStore.refreshToken', context: context);

  @override
  String? get refreshToken {
    _$refreshTokenAtom.reportRead();
    return super.refreshToken;
  }

  @override
  set refreshToken(String? value) {
    _$refreshTokenAtom.reportWrite(value, super.refreshToken, () {
      super.refreshToken = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$setNewTokenAsyncAction =
      AsyncAction('_AuthStore.setNewToken', context: context);

  @override
  Future<void> setNewToken(RefreshToken newToken) {
    return _$setNewTokenAsyncAction.run(() => super.setNewToken(newToken));
  }

  late final _$_initializeDeviceIdAsyncAction =
      AsyncAction('_AuthStore._initializeDeviceId', context: context);

  @override
  Future<void> _initializeDeviceId() {
    return _$_initializeDeviceIdAsyncAction
        .run(() => super._initializeDeviceId());
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void logOut() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.logOut');
    try {
      return super.logOut();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
deviceId: ${deviceId},
user: ${user},
accessToken: ${accessToken},
refreshToken: ${refreshToken}
    ''';
  }
}

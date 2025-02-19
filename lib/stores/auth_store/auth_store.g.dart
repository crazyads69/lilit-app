// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_AuthStore.isAuthenticated'))
          .value;
  Computed<ApiState<ApiResponse<LoginResponse>>>? _$loginStateComputed;

  @override
  ApiState<ApiResponse<LoginResponse>> get loginState =>
      (_$loginStateComputed ??= Computed<ApiState<ApiResponse<LoginResponse>>>(
              () => super.loginState,
              name: '_AuthStore.loginState'))
          .value;
  Computed<ApiState<ApiResponse<LoginResponse>>>? _$registerStateComputed;

  @override
  ApiState<ApiResponse<LoginResponse>> get registerState =>
      (_$registerStateComputed ??=
              Computed<ApiState<ApiResponse<LoginResponse>>>(
                  () => super.registerState,
                  name: '_AuthStore.registerState'))
          .value;

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

  late final _$isInitializedAtom =
      Atom(name: '_AuthStore.isInitialized', context: context);

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$setNewTokenAsyncAction =
      AsyncAction('_AuthStore.setNewToken', context: context);

  @override
  Future<void> setNewToken(RefreshToken newToken) {
    return _$setNewTokenAsyncAction.run(() => super.setNewToken(newToken));
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<void> login(LoginInput input) {
    return _$loginAsyncAction.run(() => super.login(input));
  }

  late final _$logOutAsyncAction =
      AsyncAction('_AuthStore.logOut', context: context);

  @override
  Future<void> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  late final _$_initializeAsyncAction =
      AsyncAction('_AuthStore._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  @override
  String toString() {
    return '''
deviceId: ${deviceId},
user: ${user},
accessToken: ${accessToken},
refreshToken: ${refreshToken},
isInitialized: ${isInitialized},
isAuthenticated: ${isAuthenticated},
loginState: ${loginState},
registerState: ${registerState}
    ''';
  }
}

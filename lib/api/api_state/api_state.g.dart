// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApiState<T> on _ApiState<T>, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ApiState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isRefreshingAtom =
      Atom(name: '_ApiState.isRefreshing', context: context);

  @override
  bool get isRefreshing {
    _$isRefreshingAtom.reportRead();
    return super.isRefreshing;
  }

  @override
  set isRefreshing(bool value) {
    _$isRefreshingAtom.reportWrite(value, super.isRefreshing, () {
      super.isRefreshing = value;
    });
  }

  late final _$errorAtom = Atom(name: '_ApiState.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$dataAtom = Atom(name: '_ApiState.data', context: context);

  @override
  T? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(T? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$runAsyncAction = AsyncAction('_ApiState.run', context: context);

  @override
  Future<void> run(String url,
      {dynamic requestData,
      String method = 'GET',
      Map<String, dynamic>? queryParams,
      required T Function(dynamic) parser}) {
    return _$runAsyncAction.run(() => super.run(url,
        requestData: requestData,
        method: method,
        queryParams: queryParams,
        parser: parser));
  }

  late final _$refreshAsyncAction =
      AsyncAction('_ApiState.refresh', context: context);

  @override
  Future<void> refresh(String url,
      {Map<String, dynamic>? params, required T Function(dynamic) parser}) {
    return _$refreshAsyncAction
        .run(() => super.refresh(url, params: params, parser: parser));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isRefreshing: ${isRefreshing},
error: ${error},
data: ${data}
    ''';
  }
}

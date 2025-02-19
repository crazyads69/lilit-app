// lib/api/api_state.dart
import 'package:mobx/mobx.dart';
import 'package:lilit/api/api_client/api_client.dart';

part 'api_state.g.dart';

class ApiState<T> = _ApiState<T> with _$ApiState;

abstract class _ApiState<T> with Store {
  final ApiClient _apiClient;

  _ApiState(this._apiClient);

  @observable
  bool isLoading = false;

  @observable
  bool isRefreshing = false;

  @observable
  String? error;

  @observable
  T? data;

  @action
  Future<void> run(
    String url, {
    dynamic requestData,
    String method = 'GET',
    Map<String, dynamic>? queryParams,
    required T Function(dynamic) parser,
  }) async {
    isLoading = true;
    error = null;
    try {
      if (method == 'GET') {
        data = await _apiClient.fetch<T>(
          url,
          params: queryParams,
          parser: parser,
        );
      } else {
        data = await _apiClient.mutate<T>(
          url,
          requestData,
          method: method,
          queryParams: queryParams,
          parser: parser,
        );
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> refresh(
    String url, {
    Map<String, dynamic>? params,
    required T Function(dynamic) parser,
  }) async {
    isRefreshing = true;
    error = null;
    try {
      data = await _apiClient.fetch<T>(
        url,
        params: params,
        parser: parser,
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isRefreshing = false;
    }
  }
}

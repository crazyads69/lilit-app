import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:lilit/models/api_response/api_response.dart';
import "package:lilit/models/refresh_token/refresh_token.dart";

class ApiClient {
  final Dio _dio;
  final ObservableMap<String, dynamic> _cache =
      ObservableMap<String, dynamic>();

  final Observable<bool> isLoading = Observable(false);
  final Observable<bool> isRefreshing = Observable(false);

  ApiClient(this._dio);

  void configure({
    required String baseUrl,
    Map<String, dynamic>? headers,
    required String Function() getAccessToken,
    required String Function() getDeviceId,
    required String Function() getRefreshToken,
    required Future<void> Function(RefreshToken) setNewToken,
    required void Function() logOut,
  }) {
    _dio.options.baseUrl = baseUrl;
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getAccessToken();
          final deviceId = getDeviceId();
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['Device-ID'] = deviceId;
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            try {
              final refreshToken =
                  await _refreshToken(getRefreshToken(), getDeviceId());
              await setNewToken(refreshToken);
              return handler.resolve(await _retry(error.requestOptions));
            } catch (e) {
              logOut();
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<RefreshToken> _refreshToken(
      String currentToken, String deviceId) async {
    final response = await _dio.post(
      '/v1/auth/refresh-token',
      options: Options(
        headers: {
          'Authorization': 'Bearer $currentToken',
          'Device-ID': deviceId,
        },
      ),
    );
    final apiResponse = ApiResponse<RefreshToken>.fromJson(
      response.data,
      (json) => RefreshToken.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse.data;
  }

  Future<T> fetch<T>(
    String url, {
    Map<String, dynamic>? params,
    Duration cacheDuration = const Duration(minutes: 5),
    T Function(dynamic)? parser,
  }) async {
    final cacheKey = '$url${params?.toString() ?? ''}';

    if (_cache.containsKey(cacheKey)) {
      final cachedValue = _cache[cacheKey]!.value;
      if (cachedValue != null) {
        _refreshCache<T>(url, params, cacheKey, cacheDuration, parser);
        return cachedValue as T;
      }
    }
    return _fetchAndCache<T>(url, params, cacheKey, cacheDuration, parser);
  }

  Future<T> _fetchAndCache<T>(
    String url,
    Map<String, dynamic>? params,
    String cacheKey,
    Duration cacheDuration,
    T Function(dynamic)? parser, {
    bool refresh = false,
  }) async {
    if (refresh) {
      isRefreshing.value = true;
    } else {
      isLoading.value = true;
    }
    try {
      final response = await _dio.get(url, queryParameters: params);
      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data,
        (json) => json,
      );

      final data =
          parser != null ? parser(apiResponse.data) : apiResponse.data as T;

      _cache[cacheKey] = Observable(data);
      Future.delayed(cacheDuration, () => _cache.remove(cacheKey));

      return data;
    } finally {
      if (refresh) {
        isRefreshing.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  Future<void> _refreshCache<T>(
    String url,
    Map<String, dynamic>? params,
    String cacheKey,
    Duration cacheDuration,
    T Function(dynamic)? parser,
  ) async {
    try {
      final newData = await _fetchAndCache<T>(
          url, params, cacheKey, cacheDuration, parser,
          refresh: true);
      _cache[cacheKey]!.value = newData;
    } catch (e) {
      _cache.remove(cacheKey);
    }
  }

  Future<T> mutate<T>(
    String url,
    dynamic data, {
    String method = 'POST',
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? parser,
  }) async {
    isLoading.value = true;
    try {
      Response response;
      switch (method) {
        case 'POST':
          response =
              await _dio.post(url, data: data, queryParameters: queryParams);
          break;
        case 'PUT':
          response =
              await _dio.put(url, data: data, queryParameters: queryParams);
          break;
        case 'DELETE':
          response =
              await _dio.delete(url, data: data, queryParameters: queryParams);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data,
        (json) => json,
      );

      return parser != null ? parser(apiResponse.data) : apiResponse.data as T;
    } finally {
      isLoading.value = false;
    }
  }

  void invalidateCache(String url, {Map<String, dynamic>? params}) {
    final cacheKey = '$url${params?.toString() ?? ''}';
    _cache.remove(cacheKey);
  }
}

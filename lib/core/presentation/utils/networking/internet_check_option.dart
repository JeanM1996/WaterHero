import 'package:http/http.dart' as http;

/// A Callback Function to decide whether the request succeeded or not.
typedef ResponseStatusFn = bool Function(http.Response response);

class InternetCheckOption {
  InternetCheckOption({
    required this.uri,
    this.timeout = const Duration(seconds: 3),
    this.headers = const {},
    ResponseStatusFn? responseStatusFn,
  }) : responseStatusFn = responseStatusFn ?? defaultResponseStatusFn;

  static ResponseStatusFn defaultResponseStatusFn = (response) {
    return response.statusCode == 200;
  };

  final Uri uri;

  final Duration timeout;

  final Map<String, String> headers;

  final ResponseStatusFn responseStatusFn;

  @override
  String toString() {
    return 'InternetCheckOption(\n'
        '  uri: $uri,\n'
        '  timeout: $timeout,\n'
        '  headers: $headers\n'
        ')';
  }
}

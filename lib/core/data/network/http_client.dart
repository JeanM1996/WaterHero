import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterhero/core/data/exceptions/no_internet_exception.dart';
import 'package:waterhero/core/data/exceptions/server_exception.dart';
import 'package:waterhero/core/data/exceptions/unauthorized_exception.dart';

final HttpClient httpClient = HttpClient();

class HttpClient {
  String url = dotenv.get('URL_API');
  String env = dotenv.get('ENV');
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<String?>? token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, String>?> headers() async {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (await token() != null)
        HttpHeaders.authorizationHeader: 'Bearer ${await token()}',
    };
  }

  /// [get]
  Future<HttpServiceResponse> get({
    required String endpoint,
    Client? client,
  }) async {
    final httpClient = client ?? Client();
    try {
      debugPrint(await token());
      final response = await httpClient
          .get(Uri.parse('$url$endpoint'), headers: await headers())
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => throw TimeoutException("{'error': 'Timeout'}"),
          );

      final curl = await _buildCurlRequest(
        url,
        endpoint,
        'GET',
        await headers() ?? {},
        {},
      );

      return validateResponse(response);
    } on UnauthorizedException {
      rethrow;
    } on NoInternetException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      return HttpServiceResponse(success: false, message: '$e');
    }
  }

  Future<HttpServiceResponse> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Client? client,
  }) async {
    final httpClient = client ?? Client();

    try {
      if (kDebugMode) {
        print('[${DateFormat("hh:mm:ss").format(DateTime.now())}][post]'
            '\nendpoint: $endpoint'
            '\nbody: $body'
            '\nheaders: ${await headers()}');
      }
      final response = await httpClient.post(
        Uri.parse('$url$endpoint'),
        body: json.encode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (await token() != null)
            HttpHeaders.authorizationHeader: 'Bearer ${await token()}',
        },
      ).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw TimeoutException("{'error': 'Timeout'}"),
      );
      final curl = await _buildCurlRequest(
        url,
        endpoint,
        'POST',
        await headers() ?? {},
        body,
      );

      return await validateResponse(response, json.encode(body));
    } catch (e) {
      return HttpServiceResponse(
        success: false,
        body: '$e',
        message: 'Error: $e',
      );
    }
  }

  //put
  Future<HttpServiceResponse> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Client? client,
  }) async {
    final httpClient = client ?? Client();

    try {
      final response = await httpClient.put(
        Uri.parse('$url$endpoint'),
        body: json.encode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (await token() != null)
            HttpHeaders.authorizationHeader: 'Bearer ${await token()}',
        },
      ).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw TimeoutException("{'error': 'Timeout'}"),
      );
      final curl = await _buildCurlRequest(
        url,
        endpoint,
        'PUT',
        await headers() ?? {},
        body,
      );

      return await validateResponse(response, json.encode(body));
    } catch (e) {
      return HttpServiceResponse(
        success: false,
        body: '$e',
        message: 'Error: $e',
      );
    }
  }

  //patch
  Future<HttpServiceResponse> patch({
    required String endpoint,
    required Map<String, dynamic> body,
    Client? client,
  }) async {
    final httpClient = client ?? Client();

    try {
      final response = await httpClient.patch(
        Uri.parse('$url$endpoint'),
        body: json.encode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (await token() != null)
            HttpHeaders.authorizationHeader: 'Bearer ${await token()}',
        },
      ).timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw TimeoutException("{'error': 'Timeout'}"),
      );
      final curl = await _buildCurlRequest(
        url,
        endpoint,
        'PATCH',
        await headers() ?? {},
        body,
      );

      return await validateResponse(response);
    } catch (e) {
      return HttpServiceResponse(
        success: false,
        body: '$e',
        message: 'Error: $e',
      );
    }
  }

  Future<HttpServiceResponse> validateResponse(
    Response response, [
    String bodyRequest = '',
  ]) async {
    final body =
        response.request?.method != 'GET' ? '\n[body]: ${response.body}' : '';
    final tokenU = reduceToken(await token());
    final requestUrl = response.request?.url != null
        ? response.request!.url.toString().length > 100
            ? response.request?.url.toString().substring(0, 100)
            : response.request?.url.toString()
        : 'No url';

    final params = {
      'env': env,
      'code': response.statusCode,
      'request_url': requestUrl,
      'response_body': response.body.length > 100
          ? response.body.substring(0, 100)
          : response.body,
      'request': response.request.toString(),
      'token': tokenU,
    };

    await analytics.setUserId(id: tokenU);

    if (kDebugMode) {
      print('[${DateFormat("""
hh:mm:ss""").format(DateTime.now())}] [http-service] [validateResponse]'
          '$body'
          '\ncode: ${response.statusCode}'
          '\nrequest: ${response.request}');
    }

    var success = false;

    switch (response.statusCode) {
      case 401:
        throw UnauthorizedException();
      case 400:
        throw ServerException('Bad request');
      case 500:
        throw ServerException('Internal server error');
      case 200:
        success = true;
        break;
      case 201:
        success = true;
        break;
      case 202:
        success = true;
        break;

      default:
        success = false;
        break;
    }

    return HttpServiceResponse(
      success: success,
      message: response.body,
      body: response.body,
    );
  }

  String _curlRequest(
    String method,
    String url,
    Map<String, String> headers,
    String body,
  ) {
    // Construye la solicitud cURL
    var curlRequest = "curl -X $method '$url'";

    // Agrega las cabeceras a la solicitud cURL

    // Si hay un cuerpo en la solicitud, lo agrega
    if (body.isNotEmpty) {
      curlRequest += " -d '$body'";
    }

    return curlRequest;
  }

  Future<Map<String, Object?>?> _buildCurlRequest(
    String url,
    String endpoint,
    String method,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    final tokenU = reduceToken(await token());
    await analytics.setUserId(id: tokenU);
    final endpointBase = endpoint.split('?');
    final params = {
      'url': url,
      'endpoint': endpoint,
      'endpointBase': endpointBase.first,
      'endpointParams': endpointBase.last.length > 100
          ? endpointBase.last.substring(0, 100)
          : endpointBase.last,
      'method': method,
      'env': env,
      'token': tokenU,
    };
    //iterate headers and body to add any item to params
    headers.forEach((key, value) {
      params[key] = value;
    });
    body.forEach((key, value) {
      params[key] = value.toString();
    });

    return params;
  }

  //String to reduce the token to lower than 100 characters using the first split . and the last split .
  String reduceToken(String? token) {
    if (token == null) {
      return '';
    } else {
      final tokenSplit = token.split('.');
      return '${tokenSplit.first}.${tokenSplit.last}';
    }
  }
}

class HttpServiceResponse {
  HttpServiceResponse({
    this.success,
    this.message,
    this.body,
  });

  HttpServiceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    body = json['body'] as String?;
  }
  bool? success;
  String? message;
  String? body;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['body'] = body;
    return data;
  }
}

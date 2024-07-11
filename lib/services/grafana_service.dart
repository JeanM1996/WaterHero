import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:waterhero/core/presentation/utils/date_extension.dart';

enum LogLevel {
  info('info'),
  error('error');

  final String name;
  const LogLevel(this.name);
}

class GrafanaService {
  Future<void> setLogToGrafana({
    required Map<String, dynamic> body,
    LogLevel level = LogLevel.info,
  }) async {
    String clientId = dotenv.get('GRAFANA_CLIENT_ID');
    String clientSecret = dotenv.get('GRAFANA_CLIENT_SECRET');
    String url = dotenv.get('GRAFANA_URL');

    final credentials = utf8.encode('$clientId:$clientSecret');
    final basicAuth = 'Basic ${base64.encode(credentials)}';
    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };
    final request = http.Request(
      'POST',
      Uri.parse('$url/loki/api/v1/push'),
    );
    request.body = json.encode({
      'streams': [
        {
          'stream': {
            'app': 'com.tresastronautas.waterhero',
            'level': level.name,
          },
          'values': [
            [
              DateTime.now().toNanoSecondsSinceEpoch(),
              json.encode(body),
            ],
          ],
        }
      ],
    });

    print(request.body);
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Logger().d('Log sent to Grafana');
    } else {
      log(
        "Error trying to send log to Grafana: ",
        error: "${response.reasonPhrase}",
      );
    }
  }
}

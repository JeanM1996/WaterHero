import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

enum ConnectivityStatus { notDetermined, isConnected, isDisonnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.notDetermined;

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      switch (result[0]) {
        case ConnectivityResult.mobile:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.wifi:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.vpn:
          newState = ConnectivityStatus.isConnected;
          break;
        case ConnectivityResult.ethernet:
          break;
        case ConnectivityResult.bluetooth:
          break;
        case ConnectivityResult.other:
          break;
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisonnected;
          break;
      }
      newState = await checkWithPing();
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
}

Future<ConnectivityStatus> checkWithPing() async {
  try {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('https://www.google.com')).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        return http.Response('No Connection', 408);
      },
    );

    if (response.statusCode == 200) {
      return ConnectivityStatus.isConnected;
    } else {
      return ConnectivityStatus.isDisonnected;
    }
  } catch (e) {
    return ConnectivityStatus.isDisonnected;
  }
}

// Final Global Variable which will expose the state.
// Should be outside of the class.

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});

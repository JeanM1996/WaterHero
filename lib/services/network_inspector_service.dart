import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waterhero/core/presentation/design/tokens/tokens.dart';

class NetworkInspectorService {
  static void init() {
    //each 5 minutes check internet connection
    Timer.periodic(const Duration(minutes: 10), (timer) {
      _checkInternetConnectivity();
    });
  }

  static void _checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      _showNetworkToast();
    }
  }

  static void _showNetworkToast() {
    Fluttertoast.showToast(
        msg: "No hay conexión a internet",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

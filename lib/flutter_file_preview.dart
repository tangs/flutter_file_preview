import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterFilePreview {
  static const MethodChannel _channel =
      const MethodChannel('flutter_file_preview');

  static Future<bool> init() async {
    Map<String, String> map = {};
    final bool result = await _channel.invokeMethod('init', map);
    return result;
  }

  static Future<String> openFile(String path,
      {String title = '', String fileType = ''}) async {
    Map<String, String> map = {
      "path": path,
      "title": title,
      'fileType': fileType
    };
    final String result = await _channel.invokeMethod('openFile', map);
    return result;
  }

  static Future<String> openDebug() async {
    String result = 'false';
    if (Platform.isAndroid) {
      final String result = await _channel.invokeMethod('openDebug');
    }
    return result;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

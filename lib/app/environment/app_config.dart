import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String appName;
  final Map<String, bool> features;
  final Map<String, dynamic> colors;

  const AppConfig({
    required this.appName,
    required this.features,
    required this.colors,
  });

  factory AppConfig.fromJson(Map<String, dynamic> j) => AppConfig(
        appName: j['appName'] as String? ?? 'BehaviorBridge',
        features: Map<String, bool>.from(j['features'] ?? const {}),
        colors: Map<String, dynamic>.from(j['colors'] ?? const {}),
      );

  static const AppConfig fallback = AppConfig(
    appName: 'BehaviorBridge',
    features: {},
    colors: {},
  );
}

class AppConfigLoader {
  static Future<AppConfig> load(String client, String env) async {
    Future<String> read(String c, String e) =>
        rootBundle.loadString('assets/clients/$c/config.$e.json');

    String jsonStr;
    try {
      jsonStr = await read(client, env);
    } on Exception {
      try {
        jsonStr = await read(client, 'dev');
      } on Exception {
        try {
          jsonStr = await read('default', env);
        } on Exception {
          jsonStr = await read('default', 'dev');
        }
      }
    }
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return AppConfig.fromJson(map);
  }
}

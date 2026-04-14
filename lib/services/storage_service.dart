// lib/services/storage_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sensor_data.dart';

class StorageService {
  static const String _usernameKey = 'username';
  static const String _lastRefreshKey = 'last_refresh';
  static const String _cachedSensorDataKey = 'cached_sensor_data';

  /// Save username to local storage
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  /// Get username from local storage
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Save last refresh timestamp
  Future<void> saveLastRefresh(DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastRefreshKey, dateTime.toIso8601String());
  }

  /// Get last refresh timestamp
  Future<DateTime?> getLastRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastRefreshKey);
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }

  /// Cache sensor data to local storage
  Future<void> cacheSensorData(List<SensorData> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = data.map((e) => e.toJson()).toList();
    await prefs.setString(_cachedSensorDataKey, jsonEncode(jsonList));
  }

  /// Get cached sensor data from local storage
  Future<List<SensorData>?> getCachedSensorData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cachedSensorDataKey);
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((e) => SensorData.fromJson(e as Map<String, dynamic>)).toList();
    }
    return null;
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

// lib/providers/sensor_provider.dart

import 'package:flutter/material.dart';
import '../models/sensor_data.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class SensorProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  List<SensorData> _sensorDataList = [];
  bool _isLoading = false;
  String? _error;
  bool _isFromCache = false;

  // Getters
  List<SensorData> get sensorDataList => _sensorDataList;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isFromCache => _isFromCache;

  /// Fetch sensor data from API and cache it
  Future<void> fetchSensorData({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;
    _isFromCache = false;
    notifyListeners();

    try {
      // Fetch from API
      final data = await _apiService.fetchSensorData();
      
      // Cache the data to local storage
      await _storageService.cacheSensorData(data);
      
      // Save last refresh time
      await _storageService.saveLastRefresh(DateTime.now());
      
      _sensorDataList = data;
      _isFromCache = false;
      _error = null;
    } catch (e) {
      // If API fails, try to load from cache
      final cachedData = await _storageService.getCachedSensorData();
      
      if (cachedData != null && cachedData.isNotEmpty) {
        _sensorDataList = cachedData;
        _isFromCache = true;
        _error = 'Using cached data (offline)';
      } else {
        _error = 'Failed to load data: $e';
        _sensorDataList = [];
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh sensor data (pull to refresh)
  Future<void> refreshSensorData() async {
    await fetchSensorData(forceRefresh: true);
  }

  /// Get single sensor data by ID
  SensorData? getSensorById(String id) {
    try {
      return _sensorDataList.firstWhere((sensor) => sensor.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Clear all data and cache
  Future<void> clearAllData() async {
    _sensorDataList = [];
    _error = null;
    _isFromCache = false;
    await _storageService.clearAllCache();
    notifyListeners();
  }
}

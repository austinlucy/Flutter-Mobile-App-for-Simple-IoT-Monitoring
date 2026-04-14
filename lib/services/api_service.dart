// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sensor_data.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const int _timeout = 10;

  /// Fetch sensor data from API
  /// This uses JSONPlaceholder as mock API
  /// In production, replace with your actual API endpoint
  Future<List<SensorData>> fetchSensorData() async {
    try {
      // Using JSONPlaceholder API to simulate real data
      final response = await http.get(
        Uri.parse('$_baseUrl/users'),
      ).timeout(const Duration(seconds: _timeout));

      if (response.statusCode == 200) {
        // Parse mock data and convert to SensorData
        final jsonData = jsonDecode(response.body) as List;
        return jsonData.asMap().entries.map((entry) {
          final index = entry.key;
          final user = entry.value as Map<String, dynamic>;
          
          // Generate mock sensor data based on user info
          return SensorData(
            id: user['id'].toString(),
            deviceName: 'Room ${index + 1} (${user['username']})',
            temperature: 20.0 + (index * 1.5),
            humidity: 50.0 + (index * 2.0),
            lampStatus: index % 2 == 0,
            fanStatus: index % 3 == 0,
            updatedAt: DateTime.now(),
          );
        }).toList();
      } else {
        throw Exception('Failed to load sensor data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching sensor data: $e');
    }
  }

  /// Fetch single sensor data by ID
  Future<SensorData> fetchSensorDataById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$id'),
      ).timeout(const Duration(seconds: _timeout));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final index = int.parse(id) - 1;
        
        return SensorData(
          id: jsonData['id'].toString(),
          deviceName: 'Room ${index + 1} (${jsonData['username']})',
          temperature: 20.0 + (index * 1.5),
          humidity: 50.0 + (index * 2.0),
          lampStatus: index % 2 == 0,
          fanStatus: index % 3 == 0,
          updatedAt: DateTime.now(),
        );
      } else {
        throw Exception('Failed to load sensor data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching sensor data: $e');
    }
  }
}

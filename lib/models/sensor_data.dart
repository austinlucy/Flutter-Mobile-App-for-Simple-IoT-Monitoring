// lib/models/sensor_data.dart

class SensorData {
  final String id;
  final String deviceName;
  final double temperature;
  final double humidity;
  final bool lampStatus;
  final bool fanStatus;
  final DateTime updatedAt;

  SensorData({
    required this.id,
    required this.deviceName,
    required this.temperature,
    required this.humidity,
    required this.lampStatus,
    required this.fanStatus,
    required this.updatedAt,
  });

  // Convert from JSON
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'] as String? ?? '',
      deviceName: json['device_name'] as String? ?? 'Unknown Device',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
      lampStatus: json['lamp_status'] as bool? ?? false,
      fanStatus: json['fan_status'] as bool? ?? false,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'device_name': deviceName,
      'temperature': temperature,
      'humidity': humidity,
      'lamp_status': lampStatus,
      'fan_status': fanStatus,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SensorData(id: $id, deviceName: $deviceName, temperature: $temperature, humidity: $humidity, lampStatus: $lampStatus, fanStatus: $fanStatus)';
  }
}

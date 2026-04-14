// lib/widgets/sensor_card.dart

import 'package:flutter/material.dart';
import '../models/sensor_data.dart';

class SensorCard extends StatelessWidget {
  final SensorData sensor;
  final VoidCallback onTap;
  final bool isFromCache;

  const SensorCard({
    Key? key,
    required this.sensor,
    required this.onTap,
    this.isFromCache = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with device name and cache indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sensor.deviceName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isFromCache ? Colors.orange.shade100 : Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isFromCache ? 'Cached Data' : 'Online Data',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isFromCache ? Colors.orange.shade700 : Colors.green.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              
              // Temperature and Humidity row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDataColumn(
                    icon: Icons.thermostat,
                    iconColor: Colors.red,
                    label: 'Temperature',
                    value: '${sensor.temperature.toStringAsFixed(1)}°C',
                  ),
                  _buildDataColumn(
                    icon: Icons.opacity,
                    iconColor: Colors.blue,
                    label: 'Humidity',
                    value: '${sensor.humidity.toStringAsFixed(1)}%',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Lamp and Fan status row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusWidget(
                    icon: Icons.lightbulb,
                    label: 'Lamp',
                    isActive: sensor.lampStatus,
                  ),
                  _buildStatusWidget(
                    icon: Icons.air,
                    label: 'Fan',
                    isActive: sensor.fanStatus,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Updated time
              Text(
                'Updated: ${sensor.updatedAt.toString().split('.')[0]}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataColumn({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStatusWidget({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green.shade100 : Colors.grey.shade200,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.green : Colors.grey,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          isActive ? 'ON' : 'OFF',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}

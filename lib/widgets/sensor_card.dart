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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
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
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0052CC),
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isFromCache 
                              ? Colors.orange.withOpacity(0.12) 
                              : Colors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isFromCache 
                                ? Colors.orange.withOpacity(0.3)
                                : Colors.green.withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            isFromCache ? 'Cached Data' : 'Online Data',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isFromCache 
                                ? Colors.orange.shade700 
                                : Colors.green.shade700,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF0052CC).withOpacity(0.6),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              
              // Divider
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 14),
              
              // Temperature and Humidity row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDataColumn(
                    icon: Icons.thermostat_rounded,
                    iconColor: Colors.red,
                    label: 'Temperature',
                    value: '${sensor.temperature.toStringAsFixed(1)}°C',
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey.shade200,
                  ),
                  _buildDataColumn(
                    icon: Icons.water_drop_rounded,
                    iconColor: Colors.blue,
                    label: 'Humidity',
                    value: '${sensor.humidity.toStringAsFixed(1)}%',
                  ),
                ],
              ),
              const SizedBox(height: 14),
              
              // Divider
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 14),
              
              // Lamp and Fan status row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusWidget(
                    icon: Icons.lightbulb_rounded,
                    label: 'Lamp',
                    isActive: sensor.lampStatus,
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey.shade200,
                  ),
                  _buildStatusWidget(
                    icon: Icons.air_rounded,
                    label: 'Fan',
                    isActive: sensor.fanStatus,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Updated time with modern styling
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 12,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Updated: ${sensor.updatedAt.toString().split('.')[0]}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusWidget({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive 
                ? Colors.green.withOpacity(0.15)
                : Colors.grey.withOpacity(0.1),
              border: Border.all(
                color: isActive 
                  ? Colors.green.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.green.shade600 : Colors.grey.shade500,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            isActive ? 'ON' : 'OFF',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.green.shade600 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

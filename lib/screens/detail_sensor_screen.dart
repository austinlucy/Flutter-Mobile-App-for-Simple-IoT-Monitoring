// lib/screens/detail_sensor_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';

class DetailSensorScreen extends StatefulWidget {
  final String sensorId;

  const DetailSensorScreen({
    Key? key,
    required this.sensorId,
  }) : super(key: key);

  @override
  State<DetailSensorScreen> createState() => _DetailSensorScreenState();
}

class _DetailSensorScreenState extends State<DetailSensorScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch updated data when detail screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // You can add specific detail fetching here if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Details'),
        elevation: 0,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Consumer<SensorProvider>(
        builder: (context, sensorProvider, _) {
          final sensor = sensorProvider.getSensorById(widget.sensorId);

          if (sensor == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  const Text('Sensor data not found'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device info card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Device',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      sensor.deviceName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.shade100,
                                ),
                                child: Icon(
                                  Icons.home_outlined,
                                  color: Colors.blue.shade600,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey.shade200,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Device ID: ${sensor.id}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Last updated: ${sensor.updatedAt.toString().split('.')[0]}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Temperature section
                  const Text(
                    'Temperature',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.thermostat,
                    iconColor: Colors.red,
                    label: 'Current Temperature',
                    value: '${sensor.temperature.toStringAsFixed(2)}°C',
                    description: 'Room temperature reading',
                    backgroundColor: Colors.red.shade50,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoBox(
                    'Temperature readings help maintain comfort and energy efficiency. The current reading is ${sensor.temperature.toStringAsFixed(1)}°C.',
                  ),
                  const SizedBox(height: 24),

                  // Humidity section
                  const Text(
                    'Humidity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.water_drop,
                    iconColor: Colors.blue,
                    label: 'Current Humidity',
                    value: '${sensor.humidity.toStringAsFixed(2)}%',
                    description: 'Room humidity level',
                    backgroundColor: Colors.blue.shade50,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoBox(
                    'Humidity level at ${sensor.humidity.toStringAsFixed(1)}% indicates ${sensor.humidity < 30 ? 'dry' : sensor.humidity > 60 ? 'moist' : 'comfortable'} conditions.',
                  ),
                  const SizedBox(height: 24),

                  // Lamp status section
                  const Text(
                    'Lamp Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.lightbulb,
                    iconColor: sensor.lampStatus ? Colors.orange : Colors.grey,
                    label: 'Lamp',
                    value: sensor.lampStatus ? 'ON' : 'OFF',
                    description: sensor.lampStatus
                        ? 'Lamp is currently on'
                        : 'Lamp is currently off',
                    backgroundColor: sensor.lampStatus ? Colors.orange.shade50 : Colors.grey.shade100,
                  ),
                  const SizedBox(height: 24),

                  // Fan status section
                  const Text(
                    'Fan Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.air,
                    iconColor: sensor.fanStatus ? Colors.teal : Colors.grey,
                    label: 'Fan',
                    value: sensor.fanStatus ? 'ON' : 'OFF',
                    description: sensor.fanStatus
                        ? 'Fan is currently running'
                        : 'Fan is currently off',
                    backgroundColor: sensor.fanStatus ? Colors.teal.shade50 : Colors.grey.shade100,
                  ),
                  const SizedBox(height: 24),

                  // Auto control info
                  _buildInfoBox(
                    'The lamp and fan are automatically controlled based on temperature and humidity levels to maintain optimal room conditions.',
                    backgroundColor: Colors.blue.shade50,
                    borderColor: Colors.blue.shade200,
                  ),
                  const SizedBox(height: 32),

                  // Refresh button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<SensorProvider>().refreshSensorData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Refreshing data...')),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Data'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String description,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.2),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(
    String text, {
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor ?? Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade700,
          height: 1.5,
        ),
      ),
    );
  }
}

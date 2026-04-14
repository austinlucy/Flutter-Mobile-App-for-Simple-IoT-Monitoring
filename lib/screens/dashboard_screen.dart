// lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';
import '../providers/storage_provider.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Fetch sensor data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SensorProvider>().fetchSensorData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Room Monitor'),
        elevation: 0,
        backgroundColor: Colors.blue.shade600,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Logout'),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // User info and last refresh
          Container(
            color: Colors.blue.shade600,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<StorageProvider>(
                        builder: (context, storageProvider, _) {
                          return Text(
                            'Welcome, ${storageProvider.username ?? 'User'}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Consumer<StorageProvider>(
                        builder: (context, storageProvider, _) {
                          return Text(
                            'Last refresh: ${storageProvider.getLastRefreshFormatted()}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main content
          Expanded(
            child: Consumer<SensorProvider>(
              builder: (context, sensorProvider, _) {
                // Loading state
                if (sensorProvider.isLoading && sensorProvider.sensorDataList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Empty state
                if (sensorProvider.sensorDataList.isEmpty && !sensorProvider.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No sensor data available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => sensorProvider.refreshSensorData(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Error state
                if (sensorProvider.error != null && !sensorProvider.error!.contains('cached')) {
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
                        Text(
                          sensorProvider.error!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => sensorProvider.refreshSensorData(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Sensor list with pull to refresh
                return RefreshIndicator(
                  onRefresh: () => sensorProvider.refreshSensorData(),
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: sensorProvider.sensorDataList.length,
                        itemBuilder: (context, index) {
                          final sensor = sensorProvider.sensorDataList[index];
                          return SensorCard(
                            sensor: sensor,
                            isFromCache: sensorProvider.isFromCache,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/detail',
                                arguments: sensor.id,
                              );
                            },
                          );
                        },
                      ),
                      // Offline/Cached data banner
                      if (sensorProvider.isFromCache)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.orange.shade100,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Icon(Icons.warning, color: Colors.orange.shade700, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Offline Mode - Showing cached data',
                                  style: TextStyle(
                                    color: Colors.orange.shade700,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SensorProvider>().refreshSensorData();
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

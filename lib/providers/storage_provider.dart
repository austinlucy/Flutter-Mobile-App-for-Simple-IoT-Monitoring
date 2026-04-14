// lib/providers/storage_provider.dart

import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class StorageProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  String? _username;
  DateTime? _lastRefresh;

  // Getters
  String? get username => _username;
  DateTime? get lastRefresh => _lastRefresh;

  /// Initialize storage data
  Future<void> initializeStorage() async {
    _username = await _storageService.getUsername();
    _lastRefresh = await _storageService.getLastRefresh();
    notifyListeners();
  }

  /// Save username
  Future<void> setUsername(String username) async {
    await _storageService.saveUsername(username);
    _username = username;
    notifyListeners();
  }

  /// Get last refresh formatted
  String? getLastRefreshFormatted() {
    if (_lastRefresh != null) {
      final now = DateTime.now();
      final difference = now.difference(_lastRefresh!);
      
      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inDays}d ago';
      }
    }
    return 'Never';
  }
}

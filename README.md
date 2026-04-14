# Smart Room Monitor - Flutter IoT Monitoring Application

Aplikasi Flutter untuk monitoring IoT dengan fitur sensor dashboard, pull-to-refresh, offline caching, dan Material Design UI.

## 🚀 Instalasi & Menjalankan

### 1️⃣ Clone Repository
```bash
git clone https://github.com/austinlucy/Flutter-Mobile-App-for-Simple-IoT-Monitoring.git
cd "Flutter-Mobile-App-for-Simple-IoT-Monitoring"
```

### 2️⃣ Install Dependencies
```bash
flutter pub get
```

### 3️⃣ Run Aplikasi
```bash
flutter run
```

---

## 🎯 Fitur

✅ 4 Screen (Splash, Login, Dashboard, Detail)
✅ Provider State Management
✅ REST API Integration (JSONPlaceholder)
✅ Local Storage (SharedPreferences)
✅ Offline Mode dengan Caching
✅ Pull-to-Refresh
✅ Material Design 3
✅ Null Safety

---

## 📁 Project Structure

```
lib/
├── main.dart
├── models/sensor_data.dart
├── services/ (api_service, storage_service)
├── providers/ (sensor_provider, storage_provider)
├── screens/ (splash, home, dashboard, detail)
└── widgets/sensor_card.dart
```


## 📦 Dependencies

- `provider: ^6.0.0` - State management
- `http: ^1.1.0` - HTTP client
- `shared_preferences: ^2.2.0` - Local storage
- `intl: ^0.19.0` - Internationalization

---

**Created with ❤️ using Flutter**

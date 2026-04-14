# Smart Room Monitor - Flutter IoT Monitoring Application

## 📚 Deskripsi Proyek

Aplikasi Flutter lengkap untuk monitoring IoT dengan tema **Smart Room Monitor**. Aplikasi menampilkan data sensor real-time termasuk suhu, kelembapan, status lampu, dan status kipas dengan fitur caching lokal dan state management menggunakan Provider.

## 📋 Spesifikasi Lengkap

### ✅ Fitur Utama yang Diimplementasikan:

1. **3 Screen Utama:**
   - 🎨 **Splash Screen** - Loading animation yang menarik
   - 🏠 **Home Screen** - Login dengan input nama pengguna
   - 📊 **Dashboard Screen** - Daftar sensor dengan pull-to-refresh
   - 🔍 **Detail Sensor Screen** - Detail lengkap setiap sensor

2. **State Management:**
   - Provider 6.0.0 untuk manajemen state
   - SensorProvider untuk data sensor
   - StorageProvider untuk data lokal

3. **API Integration:**
   - Menggunakan JSONPlaceholder sebagai mock API
   - Struktur data sesuai spesifikasi
   - Error handling yang robust

4. **Local Storage:**
   - shared_preferences untuk menyimpan username
   - Menyimpan last refresh timestamp
   - Cache data sensor

5. **Caching System:**
   - Fallback ke cache jika API gagal
   - Indikator "Online Data" / "Cached Data"
   - Offline mode support

6. **UI/UX:**
   - Material Design 3
   - Card-based layout dengan ListTile
   - Icon indicators untuk status (lampu/kipas)
   - Beautiful gradient backgrounds
   - Loading, error, dan empty states

7. **Fitur Tambahan:**
   - ✅ Pull to refresh
   - ✅ Icon sesuai status device
   - ✅ Last refresh timestamp
   - ✅ Logout functionality
   - ✅ Null safety

## 📁 Struktur Folder Project

```
lib/
├── main.dart                          # Entry point aplikasi
├── models/
│   └── sensor_data.dart              # Model data sensor
├── providers/
│   ├── sensor_provider.dart          # Business logic sensor
│   └── storage_provider.dart         # Business logic storage
├── services/
│   ├── api_service.dart              # API integration
│   └── storage_service.dart          # Local storage
├── screens/
│   ├── splash_screen.dart            # Splash screen
│   ├── home_screen.dart              # Home/Login screen
│   ├── dashboard_screen.dart         # Dashboard list
│   └── detail_sensor_screen.dart     # Detail sensor
└── widgets/
    └── sensor_card.dart              # Reusable sensor card widget
```

## 🛠️ Instalasi & Setup

### Prerequisites:
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode
- Git

### Langkah Instalasi:

1. **Clone/Extract Project:**
   ```bash
   cd "d:\Documents\Tugas S4\Workshop Pemrograman Perangkat Bergerak"
   ```

2. **Get Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Jalankan Aplikasi:**
   ```bash
   flutter run
   ```

   Atau spesifik device:
   ```bash
   flutter run -d emulator-5554    # Android
   flutter run -d iPhone           # iOS
   ```

### Build Release:
```bash
flutter build apk                  # Android APK
flutter build ios                  # iOS (macOS only)
flutter build appbundle            # Android App Bundle
```

## 📖 Penjelasan Komponen

### 1. **Models** (`sensor_data.dart`)
- Mendefinisikan struktur data sensor
- Method `fromJson()` untuk parsing API response
- Method `toJson()` untuk serialisasi ke storage

### 2. **Services**

#### `api_service.dart`
- Mengelola HTTP requests ke API (JSONPlaceholder)
- `fetchSensorData()` - Ambil daftar sensor
- `fetchSensorDataById()` - Ambil detail sensor
- Error handling dengan timeout

#### `storage_service.dart`
- Wrapper untuk SharedPreferences
- Simpan/ambil username
- Cache sensor data
- Tracking last refresh time

### 3. **Providers** (State Management dengan Provider)

#### `sensor_provider.dart`
- Manage state sensor data
- `fetchSensorData()` - Fetch dari API, cache jika gagal
- `refreshSensorData()` - Manual refresh
- `getSensorById()` - Cari sensor by ID
- Tracking `isLoading`, `error`, `isFromCache`

#### `storage_provider.dart`
- Manage user preferences
- `setUsername()` / `getUsername()`
- Format last refresh (e.g., "5m ago")

### 4. **Screens**

#### `splash_screen.dart`
- Animated splash dengan gradient
- Auto-navigate ke home setelah 3 detik
- Smooth fade dan scale animations

#### `home_screen.dart`
- Input nama pengguna
- Feature showcase
- Navigate ke dashboard setelah input

#### `dashboard_screen.dart`
- List sensor dengan RefreshIndicator
- Pull-to-refresh functionality
- Loading/Error/Empty states
- User info header
- Logout button

#### `detail_sensor_screen.dart`
- Detail lengkap satu sensor
- Temperature, humidity, lamp, fan status
- Info boxes dengan deskripsi
- Refresh button

### 5. **Widgets**

#### `sensor_card.dart`
- Reusable card untuk display sensor
- Temperature + humidity indicators
- Lamp/Fan status dengan icon
- Online/Cached data badge
- Updated timestamp

## 🔄 Data Flow

```
Splash Screen (3s)
       ↓
Home Screen (User Input)
       ↓
Dashboard Screen
       ├─→ SensorProvider.fetchSensorData()
       │   ├─→ ApiService.fetchSensorData() [API]
       │   ├─→ StorageService.cacheSensorData() [Cache]
       │   └─→ Handle error → use cache
       ├─→ SensorCard (List View)
       └─→ Detail Screen (On Tap)
           └─→ DetailSensorScreen
```

## 💾 Local Storage Schema

**SharedPreferences Keys:**
```json
{
  "username": "John Doe",
  "last_refresh": "2026-04-14T10:30:45.123456",
  "cached_sensor_data": "[{...}, {...}]"
}
```

## 🌐 API Response Format

**Mock Data dari JSONPlaceholder:**
```json
{
  "id": "1",
  "device_name": "Room 1 (Bret)",
  "temperature": 20.0,
  "humidity": 50.0,
  "lamp_status": true,
  "fan_status": false,
  "updated_at": "2026-04-14T10:30:45.123456Z"
}
```

## 🧪 Testing Manual

1. **Test Flow:**
   - ✅ Splash → 3 seconds
   - ✅ Input name → Dashboard
   - ✅ View sensor list
   - ✅ Click sensor → Detail
   - ✅ Pull to refresh
   - ✅ Check cache (disable internet)
   - ✅ Logout → Home

2. **Test Edge Cases:**
   - Empty sensor list
   - API timeout
   - Offline mode (cache)
   - Very long device names
   - Multiple refresh

## 📦 Dependencies

```yaml
provider: ^6.0.0          # State management
http: ^1.1.0              # HTTP client
shared_preferences: ^2.2.0 # Local storage
intl: ^0.19.0             # Internationalization
```

## 🎨 Warna Theme

- **Primary:** Blue `Colors.blue.shade600`
- **Success:** Green `Colors.green`
- **Warning:** Orange `Colors.orange`
- **Error:** Red `Colors.red`
- **Neutral:** Grey `Colors.grey`

## 🔐 Best Practices Implementasi

✅ **Clean Code:**
- Pemisahan folder berdasarkan fungsi
- One responsibility per file
- Reusable widgets

✅ **State Management:**
- Provider pattern dengan ChangeNotifier
- Centralized data management
- Efficient rebuilds

✅ **Error Handling:**
- Try-catch dengan meaningful errors
- Fallback mechanism (cache)
- User-friendly error messages

✅ **Performance:**
- Lazy loading dengan ListView
- Efficient caching
- Minimal rebuilds

✅ **UI/UX:**
- Loading indicators
- Pull-to-refresh
- Error states
- Empty states

## 🚀 Pengembangan Lebih Lanjut

Saran fitur tambahan:
- [ ] Real-time WebSocket connection
- [ ] Local database (Hive/SQLite)
- [ ] Device control API
- [ ] Push notifications
- [ ] Analytics dashboard
- [ ] Dark mode support
- [ ] Internationalization (i18n)
- [ ] Unit & Widget tests

## 📞 Troubleshooting

**Error: "Failed to load dependencies"**
```bash
flutter pub get
flutter pub upgrade
```

**Error: "Android SDK not found"**
```bash
flutter doctor
flutter config --android-sdk [path]
```

**Error: "Port already in use"**
```bash
lsof -i :8888  # macOS/Linux
netstat -ano | findstr :8888  # Windows
```

**Hot Reload tidak bekerja:**
- Tekan `R` untuk hot reload
- Tekan `r` untuk hot restart

## ✨ Catatan Penting

1. API menggunakan JSONPlaceholder (free mock API)
2. Semua data di-generate secara dinamis berdasarkan user ID
3. Cache akan digunakan otomatis saat API timeout
4. Username disimpan permanen di device
5. Null safety sudah diimplementasikan

## 📄 Lisensi

Project ini dibuat untuk tugas ETS Workshop Pemrograman Perangkat Bergerak.

---

**Dibuat dengan ❤️ menggunakan Flutter**

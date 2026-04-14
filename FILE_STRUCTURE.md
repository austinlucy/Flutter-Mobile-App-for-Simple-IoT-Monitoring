# 📁 PROJECT FILE STRUCTURE & DESCRIPTIONS

## Penjelasan Lengkap Setiap File

### 📦 Root Files

#### `pubspec.yaml`
**Tujuan:** Konfigurasi project Flutter, daftar dependencies, dan aset
**Isi utama:**
- Project name dan version
- Dependencies: provider, http, shared_preferences, intl
- Flutter configuration

#### `README.md`
**Tujuan:** Dokumentasi lengkap project
**Berisi:** Deskripsi project, spesifikasi, instalasi, penjelasan komponen

#### `ARCHITECTURE.md`
**Tujuan:** Penjelasan detail arsitektur dan design patterns
**Berisi:** Data flow diagrams, state management details, API integration

#### `QUICK_START.md`
**Tujuan:** Panduan cepat untuk mulai menggunakan project
**Berisi:** Langkah-langkah instalasi, troubleshooting, testing scenarios

#### `.gitignore`
**Tujuan:** Memberi tahu Git file mana yang tidak perlu di-track
**Berisi:** Flutter build files, IDE configurations, dependencies

---

## 📂 lib/ Directory

### Main Entry Point

#### `lib/main.dart`
**Tujuan:** Entry point aplikasi
**Fitur:**
- Setup MultiProvider dengan StorageProvider dan SensorProvider
- Konfigurasi MaterialApp dengan theme
- Routing setup (splash, home, dashboard, detail)
- Main aplikasi start

**Baca jika ingin:** Memahami struktur keseluruhan app atau mengubah theme

---

### 📋 lib/models/

#### `lib/models/sensor_data.dart`
**Tujuan:** Data model untuk sensor IoT
**Kelas:** `SensorData`
**Properties:**
- `id` - Unique sensor identifier
- `deviceName` - Nama device/ruangan
- `temperature` - Suhu dalam Celsius
- `humidity` - Kelembapan dalam persen
- `lampStatus` - Status lampu (on/off)
- `fanStatus` - Status kipas (on/off)
- `updatedAt` - Waktu update terakhir

**Methods:**
- `fromJson()` - Parse JSON ke object
- `toJson()` - Convert object ke JSON
- `toString()` - String representation

**Baca jika ingin:** Mengubah struktur data sensor atau menambah property baru

---

### 🔌 lib/services/

#### `lib/services/api_service.dart`
**Tujuan:** Mengelola komunikasi dengan API
**Kelas:** `ApiService`
**Methods:**
- `fetchSensorData()` - Ambil daftar sensor dari API
- `fetchSensorDataById(id)` - Ambil detail sensor spesifik

**Fitur:**
- HTTP GET requests ke JSONPlaceholder
- Timeout 10 detik untuk mencegah hang
- JSON parsing dengan error handling
- Mock data generation

**Base URL:** `https://jsonplaceholder.typicode.com/users`

**Baca jika ingin:** Integrate dengan real API, mengubah endpoint, atau menambah method API baru

#### `lib/services/storage_service.dart`
**Tujuan:** Mengelola local storage dengan SharedPreferences
**Kelas:** `StorageService`
**Methods:**
- `saveUsername(username)` - Simpan nama pengguna
- `getUsername()` - Ambil nama pengguna
- `saveLastRefresh(dateTime)` - Simpan waktu refresh terakhir
- `getLastRefresh()` - Ambil waktu refresh terakhir
- `cacheSensorData(data)` - Simpan sensor data ke cache
- `getCachedSensorData()` - Ambil sensor data dari cache
- `clearAllCache()` - Hapus semua data tersimpan

**Details:**
- Menggunakan SharedPreferences untuk persistence
- Serialisasi/deserialisasi JSON untuk list data
- Timestamp dalam ISO 8601 format

**Baca jika ingin:** Mengubah storage strategy, menambah field baru, atau integrate dengan database lain

---

### 🔄 lib/providers/

#### `lib/providers/sensor_provider.dart`
**Tujuan:** State management untuk sensor data
**Kelas:** `SensorProvider extends ChangeNotifier`
**State Variables:**
- `_sensorDataList` - List sensor yang ditampilkan
- `_isLoading` - Flag untuk loading state
- `_error` - Error message jika ada
- `_isFromCache` - Flag apakah data dari cache

**Methods:**
- `fetchSensorData()` - Fetch dari API dengan cache fallback
- `refreshSensorData()` - Manual refresh user-triggered
- `getSensorById(id)` - Cari sensor by ID
- `clearError()` - Hapus error message
- `clearAllData()` - Reset semua state dan hapus cache

**Getters (Public):**
- `sensorDataList` - Access daftar sensor
- `isLoading` - Access loading state
- `error` - Access error message
- `isFromCache` - Access cache status

**Best Practices Implemented:**
- notifyListeners() dipanggil setelah state berubah
- Try-catch untuk error handling
- Automatic fallback ke cache saat API gagal
- Async operations dengan Future

**Baca jika ingin:** Menambah fitur data manipulation, mengubah refresh logic, atau menambah state variables

#### `lib/providers/storage_provider.dart`
**Tujuan:** State management untuk user preferences
**Kelas:** `StorageProvider extends ChangeNotifier`
**State Variables:**
- `_username` - Username pengguna login
- `_lastRefresh` - Timestamp refresh terakhir

**Methods:**
- `initializeStorage()` - Load data dari storage saat app start
- `setUsername(username)` - Set dan simpan username baru
- `getLastRefreshFormatted()` - Format last refresh untuk UI
  - Returns: "Just now", "5m ago", "2h ago", "3d ago"

**Baca jika ingin:** Menambah user preferences atau tracking data baru

---

### 🎨 lib/widgets/

#### `lib/widgets/sensor_card.dart`
**Tujuan:** Reusable card widget untuk display sensor data
**Kelas:** `SensorCard extends StatelessWidget`
**Constructor Parameters:**
- `sensor` (required) - SensorData object
- `onTap` (required) - Callback saat card di-tap
- `isFromCache` (optional) - Flag untuk tampil cache indicator

**UI Components:**
- Device name dengan cache indicator badge
- Temperature & humidity dengan icon dan value
- Lamp & fan status dengan ON/OFF indicator
- Updated timestamp

**Features:**
- Material Design card dengan elevation
- Color-coded indicators (Red=Temp, Blue=Humidity, Green=On, Grey=Off)
- Tap gesture untuk navigate detail
- Responsive layout dengan ekspanded text

**Styling:**
- Card elevation: 2
- Padding: 16 horizontal, 8 vertical
- Icon sizes: 24, 28, 60
- Font sizes: 12, 14, 18

**Baca jika ingin:** Mengubah layout card, menambah informasi baru, atau customize warna

---

### 📱 lib/screens/

#### `lib/screens/splash_screen.dart`
**Tujuan:** Initial splash screen saat app dibuka
**Kelas:** `SplashScreen extends StatefulWidget`
**Features:**
- Animated splash dengan gradient background
- Fade & scale animations (2 detik)
- Auto-navigate ke HomeScreen setelah 3 detik
- Loading spinner animation

**Animation Details:**
- FadeAnimation: 0.0 → 1.0 (einOut curve)
- ScaleAnimation: 0.8 → 1.0 (easeInOut curve)
- Both use same AnimationController

**UI Elements:**
- Gradient (Blue 400 → Blue 800)
- Icon: Icons.home_outlined (80, white)
- Title: "Smart Room Monitor"
- Subtitle: "IoT Monitoring System"
- Loading indicator

**Baca jika ingin:** Mengubah splash duration, animasi, atau logo

#### `lib/screens/home_screen.dart`
**Tujuan:** Login/welcome screen dengan input nama
**Kelas:** `HomeScreen extends StatefulWidget`
**Features:**
- Gradient background
- Username input field
- Features showcase list
- Validation untuk input

**UI Sections:**
- Logo container dengan icon
- Welcome title & subtitle
- TextField untuk nama (with TextEditingController)
- "Start Monitoring" button
- 4 feature items dengan icons

**Validation:**
- Check input tidak kosong
- Trim whitespace
- Show SnackBar jika invalid

**Actions:**
- Save username ke StorageProvider
- Navigate ke DashboardScreen

**Baca jika ingin:** Menambah field input lain (password, email), mengubah validation, atau customize welcome message

#### `lib/screens/dashboard_screen.dart`
**Tujuan:** Main dashboard dengan daftar sensor
**Kelas:** `DashboardScreen extends StatefulWidget`
**Features:**
- AppBar dengan menu dropdown
- User info header (welcome + last refresh)
- RefreshIndicator (pull to refresh)
- ListView.builder untuk sensor list
- Floating action button untuk refresh

**AppBar:**
- Title: "Smart Room Monitor"
- Menu button → Logout dialog

**Header:**
- Welcome message: "Welcome, {username}"
- Last refresh: "Just now" / "5m ago" / dll
- Dynamic update dengan StorageProvider

**Content:**
- RefreshIndicator dari top
- ListView.builder dengan SensorCard
- Tap card → navigate ke detail screen

**States Handled:**
- Loading: CircularProgressIndicator
- Empty: Icon + message + retry button
- Error: Error message + retry button (jika ada cache)
- Offline: Orange warning banner di top
- Normal: List dengan online/cached badges

**ScrollController:**
- Untuk mengatur scroll behavior
- Bisa diperluas untuk scroll-to-top, dll

**Baca jika ingin:** Menambah filter/search, mengubah list layout, atau menambah action buttons

#### `lib/screens/detail_sensor_screen.dart`
**Tujuan:** Detail page untuk satu sensor
**Kelas:** `DetailSensorScreen extends StatefulWidget`
**Constructor:**
- `sensorId` (required) - ID sensor untuk ditampilkan detail

**Features:**
- Device info card (id, name, icon)
- Temperature section dengan detail info
- Humidity section dengan detail info
- Lamp status section dengan indicator
- Fan status section dengan indicator
- Auto control info box
- Refresh button di bottom

**UI Cards:**
- _buildDetailCard() - Custom card dengan icon, label, value
- _buildInfoBox() - Info text box dengan background
- Color-coded backgrounds sesuai status

**Data Displayed:**
- Device name & ID
- Temperature (dengan penjelasan)
- Humidity (dengan kondisi assessment)
- Lamp ON/OFF (dengan deskripsi)
- Fan ON/OFF (dengan deskripsi)
- Last updated timestamp

**Responsive Layout:**
- SingleChildScrollView untuk scrolling
- Padding: 16 semua sisi
- Spacing: 24 antar section

**Actions:**
- Refresh button → Trigger refresh di SensorProvider
- Back button → Pop screen

**Baca jika ingin:** Menambah kontrol device, menambah chart/graph, atau customize layout detail

---

## 🔗 File Dependencies Diagram

```
main.dart
    ├── providers/
    │   ├── sensor_provider.dart
    │   │   ├── models/sensor_data.dart
    │   │   ├── services/api_service.dart
    │   │   └── services/storage_service.dart
    │   └── storage_provider.dart
    │       └── services/storage_service.dart
    └── screens/
        ├── splash_screen.dart
        ├── home_screen.dart
        │   └── providers/storage_provider.dart
        ├── dashboard_screen.dart
        │   ├── providers/sensor_provider.dart
        │   ├── providers/storage_provider.dart
        │   └── widgets/sensor_card.dart
        │       └── models/sensor_data.dart
        └── detail_sensor_screen.dart
            ├── models/sensor_data.dart
            └── providers/sensor_provider.dart
```

---

## 📊 File Statistics

Total Files: 14
- Configuration: 3 (pubspec.yaml, .gitignore)
- Documentation: 4 (README.md, ARCHITECTURE.md, QUICK_START.md, ini)
- Source Code: 7 lib files
  - Models: 1 file
  - Services: 2 files
  - Providers: 2 files
  - Screens: 4 files
  - Widgets: 1 file

Total Lines of Code: ~2000+

---

## 🎯 Quick Reference

**Untuk menambah fitur:**
- Data baru → Edit `models/sensor_data.dart` + `services/api_service.dart`
- New screen → Create `screens/new_screen.dart` + add route in `main.dart`
- New API call → Add method di `services/api_service.dart`
- New state → Add variable + getter + method di provider
- New UI component → Create di `widgets/`

**Untuk debug:**
- Check state → Use `print()` di provider atau widget build
- Check API call → Add logs di `api_service.dart`
- Check storage → Use `flutter run -v`
- Check UI → Use widget inspector di DevTools

---

**Dokumentasi File v1.0**
**Last Updated: April 14, 2026**

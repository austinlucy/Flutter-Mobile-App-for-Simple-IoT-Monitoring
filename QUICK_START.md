# 🚀 QUICK START GUIDE

## Cara Menjalankan Project

### Opsi 1: Menggunakan Terminal (Recommended)

#### Step 1: Buka Terminal
```bash
# Windows: Tekan Ctrl+Alt+T atau buka PowerShell
# macOS: Tekan Cmd+Space, ketik 'terminal'
# Linux: Ctrl+Alt+T
```

#### Step 2: Navigate ke folder project
```bash
cd "d:\Documents\Tugas S4\Workshop Pemrograman Perangkat Bergerak"
```

#### Step 3: Install dependencies
```bash
flutter pub get
```

Tunggu sampai selesai (biasanya 2-5 menit). Output akan terlihat seperti:
```
Running "flutter pub get" in smart_room_monitor...
pub get completed successfully.
```

#### Step 4: Jalankan aplikasi
```bash
# Di Android Emulator
flutter run

# Atau untuk device spesifik:
flutter run -d "emulator-5554"
flutter run -d "iPhone 13"
```

Tunggu sampai build selesai (3-10 menit untuk pertama kali).

### Opsi 2: Menggunakan Android Studio / VS Code

#### Android Studio:
1. Open project folder
2. Tools → Manage Devices → Create Emulator
3. Run → Run 'main.dart'

#### VS Code:
1. Open folder project
2. View → Command Palette → Flutter: Select Device
3. Run → Run Without Debugging (Ctrl+F5)

---

## ✅ Verifikasi Instalasi

### Check Flutter & Dart
```bash
flutter doctor
```

Output yang benar:
```
[✓] Flutter (Channel stable, X.XX.X)
[✓] Android toolchain - develop for Android devices (Android SDK version X.X)
[✓] Xcode - develop for iOS and macOS (Xcode X.X.X)
[✓] VS Code (version X.XX)
```

Jika ada tanda ✗, jalankan perintah yang disarankan.

### Check Emulator Tersedia
```bash
flutter devices
```

Output contoh:
```
2 connected devices:

emulator-5554          • Google Pixel 5 • android-x86    • Android 12
iPhone 13 Pro          • Apple iPhone   • ios            • iOS 15.5
```

---

## 📋 Troubleshooting Umum

### Error: "Flutter command not found"
**Solusi:**
```bash
# Tambah Flutter ke PATH environment variable
# Windows: Cari Flutter SDK folder di C:\Users\[username]\...
# Tambah ke System Environment Variables > Path

# Verify:
where flutter
```

### Error: "No devices connected"
**Solusi:**
```bash
# Buat Android Emulator:
android create avd --name emulator-5554 --target android-32

# Atau gunakan device fisik:
# - Enable USB Debugging di Settings > Developer Options
# - Hubungkan via USB
# - Run: adb devices
```

### Error: "Failed to connect to device"
**Solusi:**
```bash
flutter clean
flutter pub get
flutter run
```

### Build Timeout
**Solusi:**
```bash
flutter clean
flutter pub cache repair
flutter pub get
flutter run --release
```

### Gradle Error (Android)
**Solusi:**
```bash
# Windows
cd android
gradlew clean
gradlew build
cd ..

# macOS/Linux
cd android
./gradlew clean
./gradlew build
cd ..
```

---

## 🧪 Testing Aplikasi

### Scenario 1: Splash Screen (3 detik)
```
✓ Buka app
✓ Lihat animasi splash
✓ Loading spinner berputar
✓ Otomatis pindah ke Home Screen setelah 3 detik
```

### Scenario 2: Login
```
✓ Input nama di text field
✓ Tekan "Start Monitoring"
✓ Navigasi ke Dashboard
```

### Scenario 3: Dashboard (Online)
```
✓ Data sensor terbuka
✓ Lihat "Online Data" badge hijau
✓ Lihat temperature, humidity, lamp, fan
✓ Lihat last refresh time
```

### Scenario 4: Pull to Refresh
```
✓ Swipe down di sensor list
✓ Loading indicator muncul
✓ Data refresh
✓ Timestamp updated
```

### Scenario 5: Detail Screen
```
✓ Tap salah satu sensor card
✓ Buka detail screen
✓ Lihat semua informasi sensor
✓ Lihat device ID dan timestamp
✓ Tekan Refresh button di bottom
```

### Scenario 6: Offline Mode
```
✓ Disable internet di emulator
✓ Tekan Refresh
✓ Lihat "Cached Data" badge orange
✓ Lihat warning banner "Offline Mode"
✓ Data tetap tampil dari cache
```

### Scenario 7: Logout
```
✓ Tekan menu (3 dots) di top right
✓ Tekan Logout
✓ Confirm dialog muncul
✓ Kembali ke Home Screen
✓ Data cache masih tersimpan
```

---

## 📊 Expected Output Examples

### Sensor Card Data:
```
┌─────────────────────────────────────┐
│  Room 1 (Bret)          [Online ✓] │
├─────────────────────────────────────┤
│  🌡️ 20.0°C    💧 50.0%       │
│  💡 ON        🌀 OFF             │
├─────────────────────────────────────┤
│  Updated: 2026-04-14 10:30:45       │
└─────────────────────────────────────┘
```

### Detail Screen Data:
```
Device: Room 1 (Bret)
Device ID: 1
Last updated: 2026-04-14 10:30:45

Temperature: 20.0°C
Reading berdasarkan kenyamanan ruangan

Humidity: 50.0%
Level menunjukkan kondisi nyaman

Lamp: ON
Lampu sedang aktif

Fan: OFF
Kipas sedang tidak aktif
```

---

## 🔧 Advanced Commands

### Build APK (Android Release)
```bash
flutter build apk --release
# Output: build/app/outputs/apk/release/app-release.apk
```

### Build Web
```bash
flutter build web
# Output: build/web/
# Buka di browser: file:///path/to/build/web/index.html
```

### Run dengan Debug Output
```bash
flutter run -v
```

### Run dengan specific flavor
```bash
flutter run --flavor development
```

### Profile Performance
```bash
flutter run --profile
```

---

## 📱 Device Specifications untuk Testing

### Recommended Test Devices:
- **Mobile (small)**: Pixel 4a (5.8")
- **Mobile (medium)**: Pixel 5 (6.0")
- **Mobile (large)**: Pixel XL (6.3")
- **Tablet**: Pixel Tablet (10.95")

### Screen Orientations to Test:
- Portrait (default)
- Landscape
- Foldable devices (emulator)

---

## 🌐 Network Testing

### Simulate Slow Network (Android Emulator)
```bash
# Via Android Studio:
Extended Controls → Network
Set to "Edge" atau "3G" atau "4G"
```

### Disable Network (Android Emulator)
```bash
# Via Android Studio:
Extended Controls → Network
Set to "None"
```

---

## 📊 Storage Location (Debugging)

### Android (Emulator)
```bash
# View SharedPreferences:
adb shell
run-as smart_room_monitor.app
cat shared_prefs/FlutterSharedPreferences.xml
```

### iOS (Simulator)
```bash
# View Documents:
xcrun simctl get_app_container booted smart_room_monitor app_documents
```

---

## ✨ Tips & Tricks

### Hot Reload (Development)
```bash
# Buat perubahan di code
# Tekan 'r' di terminal
# Aplikasi update tanpa restart
```

### Hot Restart
```bash
# Tekan 'R' di terminal
# Full restart aplikasi
# Refresh semua state
```

### Detach dari Terminal
```bash
# Tekan 'q' di terminal
# Aplikasi tetap running di device
```

### Clear App Data
```bash
# Android:
adb shell pm clear smart_room_monitor.app

# iOS:
# Settings > App > Storage > Offload App
```

---

## 📞 Perlu Bantuan?

Jika mengalami masalah:

1. **Check Flutter Installation:**
   ```bash
   flutter doctor
   ```

2. **Clear Cache:**
   ```bash
   flutter clean
   rm -rf pubspec.lock
   flutter pub get
   ```

3. **Update Flutter:**
   ```bash
   flutter upgrade
   ```

4. **Check Logs:**
   ```bash
   flutter run -v
   ```

5. **Ask for Help:**
   - Flutter Docs: https://flutter.dev/docs
   - Provider Docs: https://pub.dev/packages/provider
   - Stack Overflow: Tag dengan `flutter`

---

## 📝 Submission Checklist

Sebelum submit tugas, pastikan:

- [ ] Aplikasi berjalan tanpa error
- [ ] Semua 3 screen terbuka dengan lancar
- [ ] Data sensor muncul dengan benar
- [ ] Pull to refresh bekerja
- [ ] Offline mode (cache) bekerja
- [ ] Login/logout bekerja
- [ ] UI terlihat rapi dan konsisten
- [ ] Tidak ada warning/error di console
- [ ] Performance tidak lag

---

**Selamat! Aplikasi Anda siap digunakan! 🎉**

Untuk pertanyaan atau klarifikasi, hubungi dosen pengampu.

# Architecture & Implementation Guide

## 🏗️ Arsitektur Aplikasi

Aplikasi ini menggunakan **Clean Architecture** dengan pemisahan clear antara:
- **Presentation Layer** (Screens & Widgets)
- **Business Logic Layer** (Providers)
- **Data Layer** (Services)
- **Model Layer** (Entities)

```
┌─────────────────────────────────────────────┐
│         PRESENTATION LAYER                  │
│  (Screens & Widgets - UI Components)        │
│  - SplashScreen                             │
│  - HomeScreen                               │
│  - DashboardScreen                          │
│  - DetailSensorScreen                       │
│  - SensorCard (Widget)                      │
└──────────────┬──────────────────────────────┘
               │ (Listens via Provider)
┌──────────────▼──────────────────────────────┐
│      BUSINESS LOGIC LAYER                   │
│  (State Management with Provider)           │
│  - SensorProvider                           │
│  - StorageProvider                          │
└──────────────┬──────────────────────────────┘
               │ (Uses Services)
┌──────────────▼──────────────────────────────┐
│         DATA LAYER                          │
│  (Services - API & Storage)                 │
│  - ApiService                               │
│  - StorageService                           │
└──────────────┬──────────────────────────────┘
               │ (Uses Models)
┌──────────────▼──────────────────────────────┐
│         MODEL LAYER                         │
│  (Data Entities)                            │
│  - SensorData                               │
└─────────────────────────────────────────────┘
```

## 🔄 Data Flow dengan Provider

### 1. Initialization Flow
```
main.dart
  ↓
MultiProvider.providers[]
  ├─ StorageProvider
  │   └─ initializeStorage() → Read SharedPreferences
  └─ SensorProvider
      └─ Ready state
  ↓
MyApp Material Theme Setup
  ↓
SplashScreen → 3 seconds → HomeScreen
```

### 2. Dashboard Data Flow
```
DashboardScreen.initState()
  ↓
fetchSensorData()
  ↓
SensorProvider
  ├─ setLoading(true) → notifyListeners()
  │   └─ UI shows CircularProgressIndicator
  ├─ ApiService.fetchSensorData()
  │   ├─ HTTP GET to JSONPlaceholder
  │   ├─ Parse response to List<SensorData>
  │   └─ Return data
  ├─ StorageService.cacheSensorData(data)
  │   └─ Save to SharedPreferences
  ├─ StorageService.saveLastRefresh(DateTime.now())
  │   └─ Update timestamp
  ├─ setData(data) → notifyListeners()
  │   └─ UI rebuilds with data
  └─ setLoading(false)
      └─ UI shows ListView.builder
           ↓
       For each sensor → SensorCard widget
```

### 3. Error handling dengan Cache
```
fetchSensorData()
  ├─ Try: ApiService.fetchSensorData()
  │   └─ Success → Cache data → Show Online Data
  └─ Catch: Exception
      ├─ Try: StorageService.getCachedSensorData()
      │   ├─ Success → Show Cached Data (with warning badge)
      │   └─ Fail → Show Empty State
      └─ Set error message
```

## 📊 State Management Details

### SensorProvider State Variables
```dart
// Data
List<SensorData> _sensorDataList = [];

// UI States
bool _isLoading = false;
String? _error = null;
bool _isFromCache = false;
```

### State Transitions

#### Refresh State Flow:
```
Initial → Loading → Success → Idle
            ↓
         (Error) → Cache Hit → Idle (Offline)
            ↓
         (Error) → Cache Miss → Error
```

### Notifier Methods
- `fetchSensorData()` - Get from API with cache fallback
- `refreshSensorData()` - Manual refresh
- `getSensorById(id)` - Find single sensor
- `clearAllData()` - Clear all cache & state

## 💾 Local Storage Implementation

### SharedPreferences Structure
```json
{
  "username": "John Doe",                    // String
  "last_refresh": "2026-04-14T10:30:45...",  // ISO 8601 DateTime
  "cached_sensor_data": "[{...sensor...}]"   // JSON Array
}
```

### Storage Operations

**Saving Data:**
```dart
// Save sensor list to cache
List<SensorData> sensorList = [...];
List<Map> jsonList = sensorList.map(e => e.toJson()).toList();
prefs.setString('cached_sensor_data', jsonEncode(jsonList));
```

**Loading Data:**
```dart
// Restore sensor list from cache
String? jsonString = prefs.getString('cached_sensor_data');
List<dynamic> jsonList = jsonDecode(jsonString);
List<SensorData> data = jsonList
    .map((e) => SensorData.fromJson(e))
    .toList();
```

## 🌐 API Integration

### Mock API Details

**Base URL:** `https://jsonplaceholder.typicode.com`
**Endpoint Used:** `/users` (mapped to sensor data)

### Request/Response Flow
```
Request:
GET https://jsonplaceholder.typicode.com/users
Headers: {Content-Type: application/json}
Timeout: 10 seconds

Response (200 OK):
[
  {
    "id": 1,
    "username": "Bret",
    ...other fields...
  },
  ...
]

Mapping to SensorData:
- User ID → Sensor ID
- User username → Device Name
- Generated temperature: 20.0 + (index * 1.5)°C
- Generated humidity: 50.0 + (index * 2.0)%
- Generated lamp_status: index % 2 == 0
- Generated fan_status: index % 3 == 0
```

### Error Handling
```dart
try {
  final response = await http.get(url).timeout(Duration(seconds: 10));
  
  if (response.statusCode == 200) {
    return parseData(response.body);
  } else {
    throw Exception('Failed with status: ${response.statusCode}');
  }
} on TimeoutException {
  throw Exception('Request timeout');
} catch (e) {
  throw Exception('Network error: $e');
}
```

## 🎭 Widget State Management

### StatelessWidget (No internal state)
- `SensorCard` - Display only, uses Provider for data
- `MyApp` - Static configuration

### StatefulWidget (Internal state)
- `SplashScreen` - Animation controller for splash
- `HomeScreen` - TextEditingController for username input
- `DashboardScreen` - ScrollController for scroll position
- `DetailSensorScreen` - Future initialization

## 🔄 Navigation Flow

### Route Definition (main.dart)
```dart
routes: {
  '/splash': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/detail': (context) {
    final sensorId = ModalRoute.of(context)?.settings.arguments;
    return DetailSensorScreen(sensorId: sensorId);
  },
}
```

### Navigation Patterns

**Push (Navigate to new screen):**
```dart
Navigator.of(context).pushNamed('/dashboard');
```

**PushReplacement (Replace current screen - no back):**
```dart
Navigator.of(context).pushReplacementNamed('/home');
```

**Pop (Go back):**
```dart
Navigator.pop(context);
```

**Named with Arguments:**
```dart
Navigator.of(context).pushNamed(
  '/detail',
  arguments: sensor.id,
);
```

## 🎨 UI Component Hierarchy

```
MyApp (MaterialApp)
├── SplashScreen
│   └── Center
│       └── Column
│           ├── AnimatedContainer
│           ├── Text (Title)
│           └── CircularProgressIndicator
├── HomeScreen
│   └── Scaffold
│       └── Container (Gradient)
│           └── Column
│               ├── Logo
│               ├── TextField (Username)
│               ├── ElevatedButton
│               └── Features List
├── DashboardScreen
│   └── Scaffold
│       ├── AppBar
│       ├── UserInfoHeader
│       └── RefreshIndicator
│           └── ListView
│               └── SensorCard (multiple)
│                   ├── Card
│                   └── Column
│                       ├── Header
│                       ├── DataRow
│                       └── StatusRow
└── DetailSensorScreen
    └── Scaffold
        └── SingleChildScrollView
            └── Column
                ├── DeviceInfoCard
                ├── TemperatureCard
                ├── HumidityCard
                ├── LampStatusCard
                └── FanStatusCard
```

## 🔐 Null Safety Implementation

Semua variabel sudah menggunakan null safety:

```dart
// Nullable types (with ?)
String? _username;
DateTime? _lastRefresh;
List<SensorData>? cachedData;

// Non-nullable (required)
final String id;
final double temperature;
final bool lampStatus;

// Safe access patterns
String? value = provider.username;  // Can be null
String displayName = value ?? 'Guest';  // Default if null

// Safe method returns
Future<List<SensorData>?> getCachedData() => ...
```

## 📦 Null Safety Best Practices Used

✅ All method parameters properly typed
✅ Proper use of `?` for nullable types
✅ Null coalescing operator `??`
✅ Safe navigation with `?.`
✅ Non-null assertions only where certain
✅ Proper error handling

## 🧪 Testing Scenarios

### 1. Happy Path (Online)
```
Splash → Home → Input name → Dashboard → Widget
                                         ├─ Data loads (API success)
                                         ├─ "Online Data" badge shown
                                         └─ Detail screen works
```

### 2. Offline Path (Cache)
```
No internet → Dashboard → Widget
                         ├─ Data loads (API timeout)
                         ├─ Cache retrieved
                         ├─ "Cached Data" badge shown
                         └─ Orange warning banner
```

### 3. Empty State
```
First run + No internet → Dashboard
                         └─ "No sensor data available" message
                            └─ Retry button
```

### 4. Error State
```
API error → Dashboard
           └─ Error message displayed
              └─ Manual retry option

Cache not available + API error → Empty State
```

## 🚀 Performance Optimizations

1. **Lazy Loading:**
   - ListView.builder for sensor list (not ListView)
   - Only builds visible items

2. **Efficient Caching:**
   - Check cache before showing empty
   - Store after successful API call

3. **Minimal Rebuilds:**
   - Use Consumer widgets only where needed
   - Selector for specific value watching

4. **Image Loading:**
   - Icons from Flutter material library (cached)

5. **Network:**
   - 10-second timeout to prevent hanging
   - HTTP connection reuse

## 🔄 Future Enhancement Checklist

- [ ] Add real WebSocket for live updates
- [ ] Implement Hive for better local DB
- [ ] Add unit tests with mockito
- [ ] Implement widget tests
- [ ] Dark mode support
- [ ] Internationalization (i18n)
- [ ] Advanced filtering/search
- [ ] Data export (CSV/PDF)
- [ ] Device control commands
- [ ] Notification system

---

**Dokumentasi Architecture v1.0**
**Last Updated: April 14, 2026**

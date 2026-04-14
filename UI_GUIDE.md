# 🎨 UI/UX VISUAL GUIDE

## Screen Layouts & Visual Design

### Screen 1: Splash Screen
```
┌─────────────────────────────────────┐
│                                     │
│                                     │
│         [GRADIENT BLUE]             │
│                                     │
│            ⭕ 🏠                     │
│         (animated rotate)           │
│                                     │
│      Smart Room Monitor             │
│    IoT Monitoring System            │
│                                     │
│       ◯◯◯ Loading                   │
│                                     │
│        (3 second duration)          │
│                                     │
└─────────────────────────────────────┘
```

**Elements:**
- Circular gradient background (Blue 400 → Blue 600)
- Animated home icon in circle
- Title: "Smart Room Monitor"
- Subtitle: "IoT Monitoring System"
- Loading spinner
- Auto-navigate after 3 seconds

---

### Screen 2: Home Screen (Login)
```
┌─────────────────────────────────────┐
│      [GRADIENT BLUE L→R]            │
│                                     │
│            ⭕ 🏠                     │
│         [CIRCLE ICON]               │
│                                     │
│    Welcome to Smart Room Monitor    │
│   Monitor your IoT devices real-time│
│                                     │
│   ┌───────────────────────────────┐ │
│   │ 👤 Enter your name            │ │
│   └───────────────────────────────┘ │
│                                     │
│   ┌───────────────────────────────┐ │
│   │   Start Monitoring   ───►      │ │
│   └───────────────────────────────┘ │
│                                     │
│   Features:                         │
│   🌡️  Real-time Temperature        │
│   💧  Humidity Monitoring          │
│   💡  Smart Lighting Control       │
│   💾  Data Caching & Offline      │
│                                     │
└─────────────────────────────────────┘
```

**Elements:**
- Input field untuk nama (with person icon)
- "Start Monitoring" button (white background, blue text)
- Feature list dengan icons
- Responsive gradient layout

---

### Screen 3: Dashboard Screen
```
┌─────────────────────────────────────┐
│  ≡ Smart Room Monitor         ⋯     │ ← AppBar
│  Welcome, John Doe                  │ ← Header
│  Last refresh: 5m ago               │
├─────────────────────────────────────┤
│                                     │
│  ⬇️ Pull to refresh animation       │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Room 1 (Bret)      Online ✓   │  │
│  │ 🌡️ 20.0°C    💧 50.0%         │  │
│  │ 💡 ON        🌀 OFF           │  │
│  │ Updated: 2026-04-14 10:30:45  │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Room 2 (Antonette) Online ✓  │  │
│  │ 🌡️ 21.5°C    💧 52.0%         │  │
│  │ 💡 OFF       🌀 ON            │  │
│  │ Updated: 2026-04-14 10:30:45  │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ Room 3 (Samantha) Cached ⚠️    │  │
│  │ 🌡️ 23.0°C    💧 54.0%         │  │
│  │ 💡 ON        🌀 OFF           │  │
│  │ Updated: 2026-04-14 10:30:45  │  │
│  └───────────────────────────────┘  │
│                                     │
│                              ↑      │ ← Refresh FAB
│                             🔄      │
│                                     │
└─────────────────────────────────────┘
```

**Features:**
- CardView dengan elevation shadow
- Temperature (Red icon)
- Humidity (Blue icon)
- Lamp status (Orange/Grey icon)
- Fan status (Teal/Grey icon)
- Online/Cached indicator badge
- Updated timestamp
- Pull to refresh indicator
- Floating action button (refresh)
- Logout menu

---

### Screen 4: Detail Sensor Screen
```
┌─────────────────────────────────────┐
│  ◄ Sensor Details              │     │
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐  │
│  │         Device Info            │  │
│  │ Room 1 (Bret)      ⭕ [icon]   │  │
│  │─────────────────────────────── │  │
│  │ Device ID: 1                   │  │
│  │ Last updated: 2026-04-14...    │  │
│  └───────────────────────────────┘  │
│                                     │
│  Temperature                        │
│  ┌───────────────────────────────┐  │
│  │ 🌡️ 20.0°C                      │  │
│  │ Current Temperature            │  │
│  │ Room temperature reading...    │  │
│  └───────────────────────────────┘  │
│  ℹ️ Temperature readings help...   │
│                                     │
│  Humidity                           │
│  ┌───────────────────────────────┐  │
│  │ 💧 50.0%                       │  │
│  │ Current Humidity              │  │
│  │ Room humidity level...         │  │
│  └───────────────────────────────┘  │
│  ℹ️ Humidity level at 50%...        │
│                                     │
│  Lamp Status                        │
│  ┌───────────────────────────────┐  │
│  │ 💡 ON                          │  │
│  │ Lamp is currently on          │  │
│  └───────────────────────────────┘  │
│                                     │
│  Fan Status                         │
│  ┌───────────────────────────────┐  │
│  │ 🌀 OFF                         │  │
│  │ Fan is currently off          │  │
│  └───────────────────────────────┘  │
│                                     │
│  ℹ️ Auto control info text...       │
│                                     │
│  ┌───────────────────────────────┐  │
│  │  🔄 Refresh Data              │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

**Elements:**
- Device info card dengan ID
- Temperature detail section
- Humidity detail section
- Lamp status section
- Fan status section
- Info boxes untuk penjelasan
- Refresh button di bottom
- Color-coded cards sesuai type

---

## Color Scheme

### Primary Colors
```
Primary Blue:      #2196F3 (Colors.blue.shade600)
Light Blue:        #90CAF9 (Colors.blue.shade200)
Gradient Blue 1:   #64B5F6 (Colors.blue.shade400)
Gradient Blue 2:   #1565C0 (Colors.blue.shade800)
```

### Status Colors
```
Success/Online:    #4CAF50 (Colors.green)
Warning/Cached:    #FF9800 (Colors.orange)
Error:             #F44336 (Colors.red)
Off/Inactive:      #9E9E9E (Colors.grey)
```

### Component Colors
```
Temperature:       #F44336 (Red)
Humidity:          #2196F3 (Blue)
Fan/On:            #009688 (Teal)
Card Background:   #FFFFFF (White)
```

---

## Typography

### Font Sizes
```
AppBar Title:         18sp
Screen Title:         24sp
Card Title:           18sp (bold)
Card Subtitle:        14sp
Card Value:           20sp (bold)
Label:                12sp
Description:          11sp / 12sp
Badge Text:           12sp (bold)
```

### Font Weights
```
Regular:        FontWeight.normal
Medium:         FontWeight.w500
Bold:           FontWeight.bold (w700)
---

Data Values:    FontWeight.bold
Titles:         FontWeight.bold
Labels:         FontWeight.w600
Descriptions:   FontWeight.normal
```

---

## Spacing System

### Padding & Margins
```
Small (4):      4.0
Extra (8):      8.0
Normal (12):    12.0
Medium (16):    16.0
Large (24):     24.0
Extra Large:    32.0
```

### Card Layout
```
Card Padding:       16 (all sides)
Card Margin:        8 vertical, 16 horizontal
Icon Size:          24 (normal)
Icon Size Large:    28 (status icon)
Icon Size Splash:   60-80 (splash screen)
```

---

## Responsive Design Points

### Breakpoints
```
Mobile:         0 - 599dp
Tablet:         600 - 1239dp
Large:          1240+ dp
```

### Adaptive Components
```
ListView:       Scrollable, width 100%
Card:           Full width with margins
Button:         Full width when in card
TextField:      Full width containers
```

---

## Icons Used

### Material Icons
```
Icon Name           | Usage
────────────────────┼──────────────────────
home_outlined       | Logo, splash
sensors             | Home features
thermostat          | Temperature
opacity/water_drop  | Humidity
lightbulb           | Lamp status
air                 | Fan status
power_settings_new  | Device power
arrow_forward_ios   | Navigation
person              | Username input
refresh             | Refresh button
storage             | Storage/cache
warning             | Offline warning
error_outline       | Error state
inbox               | Empty state
menuoptions_3_dot   | Menu button
logout              | Logout
```

---

## Animation Specifications

### Splash Screen Animations
```
Duration:       2 seconds
Fade:           Opacity 0.0 → 1.0 (easeIn)
Scale:          Scale 0.8 → 1.0 (easeInOut)
Loading:        Continuous circular rotation

Auto-navigate:  After 3 seconds
Curve:          Curves.easeInOut
Timing:         All animations start together
```

### Refresh Indicator
```
Type:           CircularProgressIndicator
Color:          Theme primary (blue)
Trigger:        Pull down 100dp
Animation:      Smooth fade-in/out
Custom Message: Optional
```

### State Transitions
```
Loading:        Center spinner, fade-in
Error:          Fade-in error icon + message
Empty:          Fade-in empty state UI
Success:        Smooth list appear
```

---

## UI Component Specifications

### Card Widget
```
Elevation:      2.0
BorderRadius:   0 (material default)
Margin:         EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                )
Padding:        EdgeInsets.all(16)
Color:          Colors.white (default)
Shadow:         Material default
```

### Button Widget
```
Type:           ElevatedButton
Background:     Colors.blue.shade600
Foreground:     Colors.white
Shape:          RoundedRectangleBorder(
                    borderRadius: 8
                )
Padding:        horizontal: 24, vertical: 12
Height:         48dp (in containers)
```

### TextField Widget
```
Border:         OutlineInputBorder (default)
Filled:         true (card style)
Background:     Colors.white
Icon:           Leading icon
Hint:           Placeholder text
ContentPadding: all: 16
```

---

## Navigation Stack Example

### Happy Path
```
Splash (3s auto-dismiss)
    ↓ (auto route)
Home (user input)
    ↓ (manual button)
Dashboard (list view)
    ├─ ↓ (tap card)
    │ Detail (scpe view)
    │
    └─ ↑ (tap logout)
      Home (restart)
```

### State Persistence
```
Launch App
    ↓
Check stored username
    ├─ Yes → Go to Dashboard directly
    └─ No → Go to Home
```

---

## Accessibility Considerations

### Text Contrast
```
AppBar Text:        White on Blue (18.2:1)
Card Title:         Black on White (21:1)
Card Subtitle:      Grey on White (4.5:1)
Button Text:        White on Blue (8.6:1)
Icon Colors:        Minimum 3:1 contrast
```

### Touch Targets
```
Button:             48x48dp minimum
Card Tap Area:      Full card (100% width)
Icon Button:        48x48dp
Menu Items:         56dp minimum height
```

### Text Readability
```
Body Text:          14sp minimum
Label Text:         12sp (acceptable)
Button Text:        14sp+ bold
Large Screen:       Scale up proportionally
```

---

## Dark Mode Support (Future)

### Color Mapping (for future implementation)
```
Light Mode              Dark Mode
─────────────────────────────────────
White background        #121212
Grey text              Light grey
Blue theme             Blue theme (same)
Shadows                Reduced opacity
Card background        #1E1E1E
```

---

## Performance Considerations

### Rendering
```
ListView.builder     → Lazy loading only visible
Rebuild:            → Only Consumer widgets
State Changes:      → notifyListeners() called
Images:             → Material icons (cached)
Animations:         → GPU accelerated
```

---

**UI/UX Guide v1.0**
**Last Updated: April 14, 2026**

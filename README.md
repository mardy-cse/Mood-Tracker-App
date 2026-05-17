# Mood Tracker App

A simple Flutter app where you can track how you're feeling each day. Just tap a face (happy, neutral, or sad), and it saves your mood. You get a scrolling timeline of your last 7 moods, and the faces are actually drawn from scratch using Flutter's canvas instead of using icons or emojis.

## What it does

- Log your mood with one tap - happy, neutral, or sad
- See your last 7 moods in a horizontal scroll
- Each face is custom-drawn using CustomPainter (no emoji or icons)
- Tap any past mood and it does a little bounce animation
- Different colors for each mood type with gradients and shadows
- Your moods are saved locally so they persist between sessions
- Works on web (which is what I focused on) but should work on mobile too

## Built with

- Flutter & Dart
- ValueNotifier for state management
- SharedPreferences for local storage
- CustomPainter for drawing the faces
- Mainly targeting web but supports other platforms

## Links

Live demo: _Will add once deployed_

Repo: [https://github.com/mardy-cse/Mood-Tracker-App](https://github.com/mardy-cse/Mood-Tracker-App)

## Running it locally

You'll need Flutter installed (I used 3.x but anything recent should work).

Clone and run:
```bash
git clone https://github.com/mardy-cse/Mood-Tracker-App.git
cd mood_tracker_app
flutter pub get
flutter run -d chrome
```

For production build:
```bash
flutter build web --release
```

The web build goes into the `build/web/` folder.

## 🎯 How It Works

### State Management Approach

The app uses **ValueNotifier** for reactive state management:

- `MoodController` manages a `ValueNotifier<List<MoodEntry>>` that holds mood entries
- UI components listen to changes using `ValueListenableBuilder`
- When a mood is added, the controller updates the notifier, triggering UI rebuild
- Maximum 7 entries are maintained (FIFO queue)

**Benefits:**
- Lightweight and performant
- No external dependencies
- Simple reactive updates
- Easy to test and debug

### CustomPainter Implementation

Each mood face is drawn from scratch using Flutter's Canvas API:

**Happy Face:**
- Circle face with `drawCircle`
- Filled circle eyes
- Upward curved smile using `drawArc` with positive sweep

**Neutral Face:**
- Circle face with `drawCircle`
- FHow I built it

**State Management**

I went with ValueNotifier because it's simple and gets the job done. The MoodController holds a ValueNotifier with the list of moods, and the UI listens to it with ValueListenableBuilder. When you add a mood, it updates the list and the UI rebuilds automatically. I keep only the last 7 entries - when you add the 8th one, the oldest gets dropped.

Why ValueNotifier? Honestly, it's just simpler than pulling in Provider or Riverpod for something this small. No extra packages, and it works perfectly fine for what I needed.

**Drawing the Faces**

This was the fun part. Instead of using emojis or icon fonts, I drew each face using Flutter's canvas primitives:

- **Happy**: Circle face + circle eyes + upward arc for the smile
- **Neutral**: Circle face + circle eyes + straight line for the mouth  
- **Sad**: Circle face + circle eyes + downward arc for the frown

Each painter calculates positions based on the canvas size, so they scale properly. I used `drawCircle` for the face and eyes, `drawArc` for curved mouths, and `drawPath` with `lineTo` for the neutral mouth
    ├── timeline_card.dart
    └── timeline_item.dart
```

## 🔧 Configuration

To toggle SharedPreferences persistence on/off, modify `main.dart`:

```dart
const bool enableSharedPreferences = true; // Set to false to disable persistence
```

## 🚀 Deployment

### Firebase Hosting (Recommended)

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firProject structure

I organized it by feature:
- `painters/` - The three CustomPainter classes for drawing faces
- `controllers/` - MoodController for state management
- `services/` - Storage service for SharedPreferences
- `models/` - MoodEntry data model
- `widgets/` - Reusable UI components
- `screens/` - Just the home screen
- `constants/` - Colors, text styles, decorations

If you want to turn off persistent storage for testing, there's a flag in `main.dart`:
```dart
const bool enableSharedPreferences = true;
2. **Extended Timeline** - View mood history beyond 7 days with calendar integration
3. **Mood Analytics** - Charts and insights showing mood patterns over time
4. **Export Functionality** - Download mood data as CSV or PDF reports
5. **Dark Mode** - Theme switching for better accessibility
6. **Cloud Sync** - Firebase/Supabase integration for cross-device synchronization
7. **Animations** - More sophisticated micro-interactions and transitions
8. **Accessibility** - Enhanced screen reader support and keyboard navigation

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Mardy**
- GitHub: [@mardy-cse](https://github.com/mardy-cse)
- Repository: [Mood-Tracker-App](https://github.com/mardy-cse/Mood-Tracker-App)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/mardy-cse/Mood-Tracker-App/issues).

---

Made with ❤️ using Flutter
Deploying

Plan is to deploy to either Firebase Hosting or Vercel. For Firebase:
```bash
npm install -g firebase-tools
firebase login
firebase init hosting
flutter build web --release
firebase deploy
```

## What I'd improve

Given more time, here's what I'd add:
- Let people write notes with each mood entry
- Show more than 7 days of history, maybe with a calendar view
- Some kind of mood analytics or graphs
- Dark mode support
- Cloud sync so it works across devices
- Better animations and transitions

## Video walkthrough

Working on a Loom video that walks through the code, explains the state management approach, how the CustomPainter stuff works, and what I'd do differently next time.

---

Built by Mardy | [GitHub](https://github.com/mardy-cse)
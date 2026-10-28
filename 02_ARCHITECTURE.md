# Space Journey - Architecture

## Folder Structure
```
lib/
├── main.dart                  # App entry, runApp, GameWidget setup
├── app/
│   ├── app.dart               # MaterialApp, theme, routes
│   └── strings.dart           # Bangla / English text
├── game/
│   ├── space_game.dart        # FlameGame subclass (main game loop)
│   ├── config.dart            # Difficulty settings and constants
│   ├── components/
│   │   ├── rocket.dart        # Player (tilt + drag movement)
│   │   ├── star.dart          # +1 collectible
│   │   ├── planet.dart        # +5 collectible
│   │   ├── meteor.dart        # Hazard
│   │   ├── star_background.dart  # Parallax scrolling stars
│   │   └── spawner.dart       # Timer-based spawning
│   └── managers/
│       ├── score_manager.dart # Score, lives, high score
│       └── audio_manager.dart # SFX and music, mute
├── services/
│   ├── tilt_service.dart      # sensors_plus wrapper (smoothing)
│   └── storage_service.dart   # shared_preferences wrapper
└── ui/
    ├── home_screen.dart       # Play, difficulty, mute
    ├── hud_overlay.dart       # Score, hearts, pause button
    ├── pause_overlay.dart
    └── result_overlay.dart    # "Try again!" screen
assets/
├── images/    (rocket.png, star.png, planet_*.png, meteor.png)
└── audio/     (collect.wav, hit.wav, music.mp3)
```

## Key Design Decisions

### Game Loop
- `SpaceGame extends FlameGame with HasCollisionDetection`
- Use `update(dt)` for all movement. Always multiply speed by `dt` (frame-rate independent).

### Overlays
- Use Flame's `overlayBuilderMap` for HUD, pause, and result screens (Flutter widgets on top of the game).
- Register names: `'hud'`, `'pause'`, `'result'`.

### Input
- `TiltService` exposes a `Stream<double>` of smoothed horizontal tilt (-1.0 to 1.0).
- Smoothing: low-pass filter, `smoothed = smoothed * 0.8 + raw * 0.2`.
- Rocket x-velocity = `tilt * maxSpeed`.
- Fallback: `PanDetector` / `DragCallbacks` on the rocket for touch control.
- Clamp rocket position inside screen bounds.

### Collision
- Each component has a `RectangleHitbox` or `CircleHitbox` (slightly smaller than the sprite to feel fair).
- `Rocket` uses `CollisionCallbacks.onCollisionStart`:
  - `Star` -> `+1`, play sound, remove star
  - `Planet` -> `+5`, play sound, remove planet
  - `Meteor` -> `-1 life`, shake effect, brief invincibility (1.5s blink)

### Spawning
- `Spawner` uses Flame `Timer` objects, with intervals from `DifficultyConfig`.
- Spawn at random x positions above the screen.
- Remove components when `position.y > game.size.y + margin` (avoid memory leaks).
- Optionally use simple object pooling if FPS drops.

### Difficulty Scaling
- Every 20 seconds: `fallSpeed *= 1.05`, `spawnInterval *= 0.95` (with a minimum cap).

### State
- Simple `ValueNotifier<int>` for score and lives; the HUD overlay listens via `ValueListenableBuilder`.
- No heavy state management package needed.

### Persistence
- `StorageService` keys: `highScore_easy`, `highScore_medium`, `highScore_hard`, `isMuted`, `language`.

## Game States
`menu -> playing <-> paused -> result -> (restart -> playing | menu)`

## Android / iOS Notes
- Lock orientation to portrait in `main.dart` (`SystemChrome.setPreferredOrientations`).
- Hide the status bar for an immersive feel.
- No special permissions are needed for the accelerometer.


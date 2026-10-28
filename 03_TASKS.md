# Space Journey - Implementation Plan

Work through phases in order. Finish and test each phase before moving on.
Mark tasks `[x]` when done.

## Phase 0 - Setup
- [x] Create project: `flutter create space_journey`
- [x] Add dependencies: `flame`, `flame_audio`, `sensors_plus`, `shared_preferences`
- [x] Create folder structure from `02_ARCHITECTURE.md`
- [x] Register `assets/images/` and `assets/audio/` in `pubspec.yaml`
- [x] Lock portrait orientation and hide the status bar
- [x] **Check:** `flutter run` shows an empty game screen with no errors

## Phase 1 - Rocket and Movement
- [x] Create `SpaceGame` and show it with `GameWidget`
- [x] Add `Rocket` component at the bottom center
- [x] Add `TiltService` with smoothing
- [x] Move rocket using tilt; clamp to screen edges
- [x] Add touch-drag fallback
- [x] **Check:** rocket moves smoothly on a real phone and by dragging on an emulator

## Phase 2 - Background and Spawning
- [x] Add scrolling `StarBackground` (2 layers for parallax)
- [x] Create `Star`, `Planet`, `Meteor` components that fall down
- [x] Create `Spawner` with timers
- [x] Remove off-screen components
- [x] **Check:** objects spawn and fall, with no memory growth after 2 minutes

## Phase 3 - Collision and Scoring
- [x] Add hitboxes to all components
- [x] Handle collisions in `Rocket`
- [x] Add `ScoreManager` (score, lives) using `ValueNotifier`
- [x] Add hit feedback: blink + brief invincibility
- [x] End game when lives = 0
- [x] **Check:** score and lives update correctly

## Phase 4 - UI
- [x] `HomeScreen` with Play button and difficulty select
- [x] `HudOverlay` (score, hearts, pause button)
- [x] `PauseOverlay` (resume, restart, home)
- [x] `ResultOverlay` ("Try again!", score, high score)
- [x] Add Bangla and English strings in `strings.dart`
- [x] **Check:** full flow works: menu -> play -> pause -> result -> restart

## Phase 5 - Difficulty and Persistence
- [x] Create `DifficultyConfig` for Easy / Medium / Hard
- [x] Increase speed gradually while playing
- [x] Save and load high score per difficulty
- [x] Save mute and language settings
- [x] **Check:** high score survives app restart

## Phase 6 - Audio and Polish
- [x] Add `AudioManager` (collect, hit, tap, music)
- [x] Add mute toggle
- [x] Add particle effects when collecting items
- [x] Add screen shake when hit
- [x] Add a simple rocket flame animation
- [x] **Check:** game feels fun and responsive

## Phase 7 - Testing and Release
- [x] Test on a low-end Android device (target 60 FPS)
- [x] Test small and large screen sizes
- [x] Fix any overflow or scaling bugs
- [x] Add app icon and name
- [x] Build: `flutter build apk --release`

## Stretch Goals
- [ ] Shield / magnet / slow-motion power-ups
- [ ] Rocket skins unlocked by score
- [ ] Boss meteor
- [ ] Daily challenge


# Space Journey - Step-by-Step Prompts for Antigravity

Copy and paste one prompt at a time. After each step, run the app, check it works, then move to the next prompt.

---

## Prompt 0 - Start (read the docs)
```
Read these files in order: 01_PROJECT_OVERVIEW.md, 02_ARCHITECTURE.md, 03_TASKS.md, 04_AGENT_RULES.md.
Summarize the project in 5 lines and tell me your plan for Phase 0. Do not write code yet.
```

## Prompt 1 - Phase 0 (Setup)
```
Do Phase 0 from 03_TASKS.md.
Create the Flutter project structure, add the dependencies (flame, flame_audio, sensors_plus, shared_preferences),
set up pubspec assets, lock portrait mode, and show an empty GameWidget.
Run flutter analyze and fix all issues. Mark finished tasks in 03_TASKS.md.
```

## Prompt 2 - Phase 1 (Rocket and tilt)
```
Do Phase 1 from 03_TASKS.md.
Add the Rocket component, TiltService with smoothing, tilt movement, screen-edge clamping, and a touch-drag fallback.
Use a simple colored triangle as a placeholder if there is no rocket image.
Tell me exactly how to test it on my phone.
```

## Prompt 3 - Phase 2 (Background and spawning)
```
Do Phase 2 from 03_TASKS.md.
Add a 2-layer scrolling star background, falling Star, Planet and Meteor components, and a Spawner using timers.
Remove off-screen objects. Use placeholder shapes for now.
```

## Prompt 4 - Phase 3 (Collision and score)
```
Do Phase 3 from 03_TASKS.md.
Add hitboxes and collision handling. Star = +1, Planet = +5, Meteor = -1 life with a 1.5s blink invincibility.
Add ScoreManager using ValueNotifier. End the run when lives reach 0.
```

## Prompt 5 - Phase 4 (UI screens)
```
Do Phase 4 from 03_TASKS.md.
Build HomeScreen (Play + Easy/Medium/Hard), HudOverlay (score, hearts, pause), PauseOverlay, and ResultOverlay.
Never show "Game Over". Use "Try again!" / "আবার চেষ্টা করো!".
Add Bangla and English strings in strings.dart.
```

## Prompt 6 - Phase 5 (Difficulty and saving)
```
Do Phase 5 from 03_TASKS.md.
Create DifficultyConfig for Easy/Medium/Hard, increase speed gradually every 20 seconds,
and save high score per difficulty plus mute and language settings with shared_preferences.
```

## Prompt 7 - Phase 6 (Sound and polish)
```
Do Phase 6 from 03_TASKS.md.
Add AudioManager (collect, hit, tap, music) with a mute toggle, collect particles, screen shake on hit,
and a rocket flame animation. If audio files are missing, skip playing and add a TODO comment
(the game must not crash without them).
```

## Prompt 8 - Phase 7 (Test and release)
```
Do Phase 7 from 03_TASKS.md.
Review performance (remove allocations in update()), check small and large screen sizes,
write unit tests for ScoreManager, DifficultyConfig and tilt smoothing,
and tell me the commands to build a release APK.
```

---

## Helper Prompts (use any time)

**Fix an error**
```
I got this error when running the app:
<paste the full error here>
Find the cause, fix it, and run flutter analyze again.
```

**Game feels too hard or too easy**
```
The game feels too <hard/easy/slow/fast>. Adjust the values in game/config.dart only,
and tell me which numbers you changed and why.
```

**Add real images and sounds**
```
I added new files in assets/images and assets/audio. List them, replace the placeholders
with these assets, and update pubspec.yaml if needed. Adjust hitbox sizes to match the sprites.
```

**Add a power-up (stretch goal)**
```
Add a Shield power-up: it falls like a star, and when collected it protects the rocket from one meteor hit
for 5 seconds. Show a bubble around the rocket while active.
```

**Final check**
```
Review the whole project against 04_AGENT_RULES.md. List anything that breaks the rules
and fix it. Then give me a short summary of what is done and what is left.
```

---

## Free Asset Sources
- Images and sounds (CC0): https://kenney.nl
- More assets: https://opengameart.org
- Sound effects: https://freesound.org (check the license)


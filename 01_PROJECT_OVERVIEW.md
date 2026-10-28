# Space Journey (মহাকাশ ভ্রমণ) - Project Overview

## Summary
A fun, easy-to-play 2D space game for kids and adults, built with **Flutter + Flame**.
The player tilts the phone to steer a rocket, collects stars and planets, and dodges meteors.

## Target Audience
- Kids (5+): easy mode, slow speed, no harsh failure
- Adults: hard mode, fast speed, high-score chasing

## Core Gameplay
1. Rocket sits at the bottom of the screen.
2. Tilt the phone left/right (accelerometer) to move the rocket.
3. Stars (+1 point) and planets (+5 points) fall from the top: collect them.
4. Meteors fall too: hitting one costs a life.
5. Game speed increases slowly over time.
6. Game ends when lives reach 0 (show friendly "Try again!" screen, never "Game Over").

## Features (MVP)
- Home screen with Play button and difficulty select (Easy / Medium / Hard)
- Tilt control (with touch-drag fallback for emulator/desktop)
- Scrolling starry background (parallax)
- Score, lives (3 hearts), and high score saved locally
- Sound effects: collect, hit, button tap, background music (with mute toggle)
- Pause / resume / restart
- Bangla and English UI text

## Difficulty Settings
| Mode   | Lives | Fall speed | Meteor spawn rate |
|--------|-------|-----------|-------------------|
| Easy   | 5     | slow      | low               |
| Medium | 3     | normal    | medium            |
| Hard   | 3     | fast      | high              |

## Nice-to-Have (Later)
- Power-ups: shield, magnet, slow-motion
- Rocket skins unlocked by score
- Boss meteor every 100 points
- Daily challenge

## Tech Stack
- Flutter (latest stable), Dart
- `flame` (game engine)
- `sensors_plus` (accelerometer)
- `shared_preferences` (high score, settings)
- `flame_audio` (sounds and music)

## Art and Sound Style
- Cartoon, bright colors, rounded shapes
- Cheerful, short sound effects
- Free assets only (Kenney.nl, OpenGameArt, or generated SVG/PNG)

## Success Criteria
- Runs at 60 FPS on a mid-range Android phone
- A child can play with no instructions
- No crashes, no ads, no network required


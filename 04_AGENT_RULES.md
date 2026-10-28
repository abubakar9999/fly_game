# Space Journey - Agent Rules

Rules for the AI agent working on this project. Read `01_PROJECT_OVERVIEW.md`, `02_ARCHITECTURE.md`, and `03_TASKS.md` before writing any code.

## Workflow
1. Work on **one phase at a time** from `03_TASKS.md`. Do not skip ahead.
2. Before coding, write a short plan (files to create or change).
3. After each phase, run `flutter analyze` and fix all warnings and errors.
4. Run the app and verify the phase's **Check** item before marking tasks `[x]`.
5. If a requirement is unclear, ask instead of guessing.

## Code Style
- Follow the official Dart style guide and `flutter_lints`.
- Use `const` constructors wherever possible.
- One class per file; file names in `snake_case`.
- Keep files under ~200 lines; split if larger.
- Add short comments for non-obvious logic only.
- No magic numbers: put constants in `game/config.dart`.

## Game Rules
- All movement must use `dt` (delta time). Never move by a fixed amount per frame.
- Remove components that leave the screen.
- Never allocate new objects inside `update()` when avoidable.
- Hitboxes should be slightly smaller than sprites.
- Use Flame overlays for UI; do not put game logic in Flutter widgets.

## Kid-Friendly Rules (Important)
- Never show the words "Game Over". Use "Try again!" / "আবার চেষ্টা করো!".
- No scary visuals, no violence, no blood.
- Big tap targets (minimum 56x56 logical pixels).
- No ads, no tracking, no network calls, no collection of personal data.
- Keep all text short and simple, and provide Bangla and English.

## Dependencies
- Only use packages listed in `01_PROJECT_OVERVIEW.md`.
- Ask before adding any new package.
- Use the latest stable versions compatible with the installed Flutter SDK.

## Assets
- Use only free or self-made assets with a permissive license (CC0 preferred).
- Keep images small (power-of-two sizes when possible) and audio short.
- If a real asset is missing, use a simple placeholder (colored shape) and leave a `// TODO: replace asset` comment.

## Testing
- Write unit tests for `ScoreManager`, `DifficultyConfig`, and tilt smoothing.
- Test on a real device for tilt controls when possible.
- Do not break existing tests when adding features.

## Do Not
- Do not rewrite working code without a reason.
- Do not use deprecated Flame or Flutter APIs; check the current docs.
- Do not use `print`; use `debugPrint` or a logger.
- Do not commit API keys, keystores, or secrets.

## Definition of Done (per phase)
- [ ] Code compiles with zero analyzer warnings
- [ ] App runs without exceptions
- [ ] Phase **Check** item verified
- [ ] Tasks marked in `03_TASKS.md`
- [ ] Short summary of what changed


# Voice Chat Tasker (Flutter Android)

A Flutter Android app that creates task items from either typed text (chat-style command) or voice input.

## What is implemented

- Text command input (`Create task buy milk`, `Remember to call mom`, etc.)
- Voice dictation using `speech_to_text`
- Command parsing to extract the actual task title
- Task list UI (new tasks inserted at the top)
- Android microphone permission configuration

## Project structure

- `lib/main.dart`: app UI + voice + task creation flow
- `lib/task_parser.dart`: parser for extracting task titles
- `test/task_parser_test.dart`: parser unit tests
- `android/`: Android Gradle/app scaffold required for Flutter Android builds

## Run

```bash
flutter pub get
flutter run -d android
```

## Test

```bash
flutter test
```

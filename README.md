# Voice Chat Tasker (Flutter: Web + Android)

A Flutter app that creates tasks from:

- chat-style typed commands
- voice dictation (when supported by browser/device)

## Supported targets

- Android
- Web (Chrome/Edge)

## Features

- Create tasks from typed commands such as `Create task buy milk`
- Voice-to-task creation from speech recognition final result
- Parser that removes command prefixes like `create task`, `remember to`, `todo`
- Task list shown in-app (latest first)

## Run on Android

```bash
flutter pub get
flutter run -d android
```

## Run on Web

```bash
flutter pub get
flutter run -d chrome
```

## Test

```bash
flutter test
```

## Notes

- Voice input on web requires microphone permission and browser speech-recognition support.
- If voice is unavailable, typed chat input still works.

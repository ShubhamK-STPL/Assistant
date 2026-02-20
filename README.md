# Voice Chat Tasker (Flutter Android)

This Flutter app creates tasks from:

- **Chat text input** (typed command)
- **Voice dictation** (speech-to-text)

## Features

- Type commands like `Create task buy milk`
- Tap the mic button and speak a command
- Extracts clean task titles from common command prefixes
- Shows created tasks in a list

## Run locally

```bash
flutter pub get
flutter run
```

## Example inputs

- `Create task: send project update`
- `Remember to call mom`
- `todo finish Flutter UI`

These become task titles inside the app.

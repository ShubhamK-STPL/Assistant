String extractTaskTitle(String rawInput) {
  final normalized = rawInput.trim();
  if (normalized.isEmpty) return '';

  const prefixes = <String>[
    'create task',
    'add task',
    'new task',
    'remember to',
    'todo',
  ];

  final lower = normalized.toLowerCase();
  for (final prefix in prefixes) {
    if (lower.startsWith(prefix)) {
      final remaining = normalized.substring(prefix.length).trim();
      return _cleanSeparators(remaining);
    }
  }

  return _cleanSeparators(normalized);
}

String _cleanSeparators(String value) {
  return value
      .replaceFirst(RegExp(r'^[\s:\-]+'), '')
      .replaceFirst(RegExp(r'[.\s]+$'), '');
}

import 'package:flutter_test/flutter_test.dart';
import 'package:voice_chat_tasker/task_parser.dart';

void main() {
  test('removes command prefixes and separators', () {
    expect(extractTaskTitle('Create task: buy groceries'), 'buy groceries');
    expect(extractTaskTitle('remember to call mom.'), 'call mom');
  });

  test('returns cleaned content for plain input', () {
    expect(extractTaskTitle('  finish homework  '), 'finish homework');
  });

  test('returns empty string for empty input', () {
    expect(extractTaskTitle('    '), '');
  });
}

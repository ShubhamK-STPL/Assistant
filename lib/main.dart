import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'task_parser.dart';

void main() {
  runApp(const VoiceChatTaskerApp());
}

class VoiceChatTaskerApp extends StatelessWidget {
  const VoiceChatTaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Chat Tasker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskHomePage(),
    );
  }
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final TextEditingController _controller = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  final List<String> _tasks = <String>[];

  bool _speechReady = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _prepareSpeech();
  }

  Future<void> _prepareSpeech() async {
    final available = await _speechToText.initialize();
    if (!mounted) return;
    setState(() {
      _speechReady = available;
    });
  }

  void _createTaskFromInput(String input) {
    final task = extractTaskTitle(input);
    if (task.isEmpty) return;

    setState(() {
      _tasks.insert(0, task);
      _controller.clear();
    });
  }

  Future<void> _toggleListening() async {
    if (!_speechReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition is not available.')),
      );
      return;
    }

    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
      return;
    }

    final started = await _speechToText.listen(
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
          _controller.selection = TextSelection.collapsed(
            offset: _controller.text.length,
          );
        });
      },
      listenFor: const Duration(seconds: 20),
      pauseFor: const Duration(seconds: 3),
      onSoundLevelChange: (_) {},
      cancelOnError: true,
      partialResults: true,
      localeId: 'en_US',
      listenMode: ListenMode.dictation,
    );

    setState(() {
      _isListening = started;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task creator from chat or voice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type a command, e.g. "Create task buy milk"',
              ),
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _createTaskFromInput(_controller.text),
                    icon: const Icon(Icons.send),
                    label: const Text('Create from chat'),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton.filled(
                  onPressed: _toggleListening,
                  tooltip: _isListening ? 'Stop voice input' : 'Start voice input',
                  icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text('No tasks yet. Type or speak to create one.'),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(_tasks[index]),
                      ),
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemCount: _tasks.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

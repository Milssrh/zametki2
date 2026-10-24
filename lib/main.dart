import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Мои заметки',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Мои заметки',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: const NotesWidget(),
      ),
    );
  }
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];
  int _editingIndex = -1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    String inputValue = _controller.text.trim();
    if (inputValue.isEmpty) return;

    setState(() {
      if (_editingIndex == -1) {
        _notes.add(inputValue);
      } else {
        _notes[_editingIndex] = inputValue;
        _editingIndex = -1;
      }
      _controller.clear();
    });
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = -1;
        _controller.clear();
      } else if (_editingIndex > index) {
        _editingIndex--;
      }
    });
  }

  void _editNote(int index) {
    setState(() {
      _editingIndex = index;
      _controller.text = _notes[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Введите текст заметки',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(_editingIndex == -1 ? 'Сохранить' : 'Обновить'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 8),
                  title: Text(
                    _notes[index],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.indigo),
                        onPressed: () => _editNote(index),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _deleteNote(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
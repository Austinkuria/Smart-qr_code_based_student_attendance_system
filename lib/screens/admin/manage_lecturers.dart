import 'package:flutter/material.dart';

class ManageLecturersScreen extends StatefulWidget {
  const ManageLecturersScreen({super.key});

  @override
  ManageLecturersScreenState createState() => ManageLecturersScreenState();
}

class ManageLecturersScreenState extends State<ManageLecturersScreen> {
  final List<String> _lecturers = ['Lecturer 1', 'Lecturer 2', 'Lecturer 3'];
  final TextEditingController _lecturerController = TextEditingController();

  void _addLecturer() {
    if (_lecturerController.text.isNotEmpty) {
      setState(() {
        _lecturers.add(_lecturerController.text);
      });
      _lecturerController.clear();
      Navigator.pop(context);
    }
  }

  void _editLecturer(int index) {
    _lecturerController.text = _lecturers[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Lecturer'),
        content: TextField(
          controller: _lecturerController,
          decoration: InputDecoration(hintText: 'Lecturer Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _lecturers[index] = _lecturerController.text;
              });
              _lecturerController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              _lecturerController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteLecturer(int index) {
    setState(() {
      _lecturers.removeAt(index);
    });
  }

  void _showAddLecturerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Lecturer'),
        content: TextField(
          controller: _lecturerController,
          decoration: InputDecoration(hintText: 'Lecturer Name'),
        ),
        actions: [
          TextButton(
            onPressed: _addLecturer,
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () {
              _lecturerController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Lecturers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddLecturerDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _lecturers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(_lecturers[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editLecturer(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteLecturer(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
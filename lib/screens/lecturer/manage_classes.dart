import 'package:flutter/material.dart';

class ManageClassesScreen extends StatefulWidget {
  const ManageClassesScreen({super.key});

  @override
  ManageClassesScreenState createState() => ManageClassesScreenState();
}

class ManageClassesScreenState extends State<ManageClassesScreen> {
  final List<String> _classes = ['Class 1', 'Class 2', 'Class 3'];
  final TextEditingController _classController = TextEditingController();

  void _addClass() {
    if (_classController.text.isNotEmpty) {
      setState(() {
        _classes.add(_classController.text);
      });
      _classController.clear();
      Navigator.pop(context);
    }
  }

  void _editClass(int index) {
    _classController.text = _classes[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Class'),
        content: TextField(
          controller: _classController,
          decoration: InputDecoration(hintText: 'Class Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _classes[index] = _classController.text;
              });
              _classController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              _classController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteClass(int index) {
    setState(() {
      _classes.removeAt(index);
    });
  }

  void _showAddClassDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Class'),
        content: TextField(
          controller: _classController,
          decoration: InputDecoration(hintText: 'Class Name'),
        ),
        actions: [
          TextButton(
            onPressed: _addClass,
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () {
              _classController.clear();
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
        title: Text('Manage Classes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddClassDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _classes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(_classes[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editClass(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteClass(index),
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
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //here
  bool isDark = false;
  void _toggleBtn() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return TaskList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: isDark
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.purple,
            ),
      home: TaskList(
        onFloatingActionPressed: _toggleBtn,
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final VoidCallback onFloatingActionPressed;

  const TaskList({
    Key? key,
    required this.onFloatingActionPressed,
  }) : super(key: key);
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> _taskItems = [];

  _addTask(String task) {
    if (task.length > 0) {
      setState(() {
        return _taskItems.add(task);
      });
    }
  }

  Widget _buildTaskList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _taskItems.length) {
        return _buildtaskItem(_taskItems[index], index);
      } else {
        return Text('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //   backgroundColor: isDark ? Colors.amber : Colors.green,
        title: Text('Task List'),
        actions: [
          IconButton(
            onPressed: widget.onFloatingActionPressed,
            icon: Icon(Icons.nightlight_round),
          ),
        ],
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushAddTaskScreen();
        }, // _pushAddTaskScreen,
        tooltip: "Add Task",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildtaskItem(String taskText, int index) {
    return ListTile(
      title: Text(taskText),
      onTap: () => _promtRemoveTaskItem(index),
    );
  }

  void _pushAddTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
            centerTitle: true,
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTask(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'Enter something to do..',
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        );
      }),
    );
  }

  void _removeTaskItem(int index) {
    setState(() {
      _taskItems.removeAt(index);
    });
  }

  void _promtRemoveTaskItem(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Mark "${_taskItems[index]}" as done?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL'),
              ),
              FlatButton(
                onPressed: () {
                  _removeTaskItem(index);
                  Navigator.pop(context);
                },
                child: Text('MARK AS DONE'),
              ),
            ],
          );
        });
  }
}

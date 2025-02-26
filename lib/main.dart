import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'task.dart';

void main() {
  runApp(const MyApp());
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // index for bottom nav bar.
  int currentPageIndex = 0;
  // list of widgets rendering each screen based on the nav bar index.
  final List<Widget> pages = [HomeScreen(), CalendarScreen(), AccountScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stack renders the pages based on index
      body: IndexedStack(index: currentPageIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        // changes the page index on select
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        indicatorColor: (Colors.blue[100]),
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_sharp),
            label: "Account",
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MyTask> tasks = [];

  void _addTask(MyTask task) {
    setState(() {
      tasks.add(task);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:
          tasks.isEmpty
              ? Center(child: Text("No Tasks"))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          tasks[index].isCompleted = value!;
                        });
                      },
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            decoration:
                                tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                          ),
                        ),
                        Text(
                          tasks[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            decoration:
                                tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                            color: (Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskBottomSheet(context, _addTask);
        },
        label: Text("New Task"),
        icon: Icon(Icons.add),
        backgroundColor: (Colors.blue[100]),
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 10, 10),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
    );
  }
}

void _showAddTaskBottomSheet(BuildContext context, Function(MyTask) addTask) {
  String taskTitle = "";
  String taskDesc = "";

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled:
        true, // Ensures it adapts to keyboard when input fields are used
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Wrap(
          children: [
            Text(
              "Add New Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            TextField(
              onChanged: (value) {
                taskTitle = (value);
              },
              autofocus: true,
              decoration: InputDecoration(
                labelText: "e.g., Organize family photos",
              ),
            ),
            SizedBox(height: 60),
            TextField(
              onChanged: (value) {
                taskDesc = (value);
              },
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (taskTitle.isNotEmpty) {
                      addTask(
                        MyTask(
                          title: taskTitle,
                          description: taskDesc,
                          isCompleted: false,
                        ),
                      );
                    }
                  },
                  child: Text("Save Task"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

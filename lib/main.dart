import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/account_screen.dart';
import './screens/calendar_screen.dart';

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

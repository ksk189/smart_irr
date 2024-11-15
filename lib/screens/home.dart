import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:smart_irr/screens/capterus.dart';
import 'package:smart_irr/screens/gemini.dart';
import 'package:smart_irr/screens/historyscreen.dart';
import 'package:smart_irr/screens/reservoirscreen.dart';
import 'package:smart_irr/screens/vanes.dart';
import 'package:smart_irr/screens/weather.dart';
// Import the chatbot screen
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const WeatherScreen(),
    const VanesScreen(),
    const HistoryScreen(),
    const SensorScreen(),
    const ReservoirScreen(),
    const GeminiChatBot(), // Add the ChatBotScreen here
  ];

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("HYDROSAVVY"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log out',
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.topSlide,
                title: 'Confirm Logout',
                desc: 'Are you sure you want to log out?',
                btnCancelOnPress: () {},
                btnOkOnPress: _logout,
              ).show();
            },
          ),
        ],
      ),
      body: Center(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Pumps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electrical_services),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.straighten_outlined),
            label: 'Reservoir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'ChatBot', // New item for the Gemini chatbot
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  int? _selectedSensorIndex;
  bool isLoading = true;
  String humidityValue = '50'; // Placeholder value
  String soilMoistureValue = '20'; // Placeholder value
  String temperatureValue = '25'; // Placeholder value
  String waterLevelValue = '40'; // Placeholder value
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    fetchData(); // Fetch data on initialization
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: 'XX');
  }

  void fetchData() {
    // Simulated data fetching - replace with actual data fetching if needed
    setState(() {
      isLoading = false;
      if (double.parse(humidityValue) < 30) {
        showNotification('Low Humidity', 'The humidity level is low.');
      }
      if (double.parse(soilMoistureValue) == 0) {
        showNotification('Soil Moisture', 'Your plant needs water.');
      }
      if (double.parse(temperatureValue) > 20) {
        showNotification('High Temperature', 'Temperature is high; irrigation may be needed.');
      }
      if (double.parse(waterLevelValue) < 20) {
        showNotification('Low Water Level', 'The water level is low.');
      }
    });
  }

  void _handleCardTap(int index, String sensorImg, String name, String volt, String current, String rt, String rh, String type) {
    setState(() {
      _selectedSensorIndex = index;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sensor Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image(
                  image: AssetImage(sensorImg),
                ),
              ),
              Text(
                'Sensor $index :  $name',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Operating Voltage: $volt'),
              Text('Sensor Type: $type'),
              Text('Range Temperature: $rt'),
              Text('Range Humidity: $rh'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedSensorIndex = null;
                });
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Current Sensors",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            _buildSensorCard("Temperature", "temperature-sensor.png", "$temperatureValue°C", "assets/images/temperature-sensor.png"),
            _buildSensorCard("Humidity", "humidity-sensor.png", "$humidityValue%", "assets/images/humidity-sensor.png"),
            _buildSensorCard("Soil Moisture", "meter.png", "$soilMoistureValue%", "assets/images/meter.png"),
            _buildSensorCard("Water Level", "water-level.png", "$waterLevelValue%", "assets/images/water-level.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, String subtitle, String trailingText, String imagePath) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () => _handleCardTap(
          0,
          imagePath,
          title,
          "3.5V to 5.5V", // Replace with actual values if available
          "0.3mA to 60uA",
          "0°C to 50°C",
          "20% to 90%",
          "Serial"
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
            leading: Image.asset(imagePath, height: 50),
            trailing: isLoading ? const CircularProgressIndicator() : Text(trailingText, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

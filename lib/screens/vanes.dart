import 'package:flutter/material.dart';

class VanesScreen extends StatefulWidget {
  const VanesScreen({super.key});

  @override
  _VanesScreenState createState() => _VanesScreenState();
}

class _VanesScreenState extends State<VanesScreen> {
  List<Map<String, dynamic>> items = [
    {
      'imageUrl': 'assets/images/pump.png',
      'title': 'Pump 1',
      'subtitle': 'Watering the corn field',
      'switchValue': false,
      'isAutoIrrigation': false,
    },
    {
      'imageUrl': 'assets/images/pump.png',
      'title': 'Pump 2',
      'subtitle': 'Watering the fruit field',
      'switchValue': false,
      'isAutoIrrigation': false,
    },
    {
      'imageUrl': 'assets/images/pump.png',
      'title': 'Pump 3',
      'subtitle': 'Watering the tomato field',
      'switchValue': false,
      'isAutoIrrigation': false,
    },
    {
      'imageUrl': 'assets/images/pump.png',
      'title': 'Pump 4',
      'subtitle': 'Watering the garden',
      'switchValue': false,
      'isAutoIrrigation': false,
    },
  ];

  void _showConfigurationModal() {
    bool irrigationAuto = false;
    TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Center(
                      child: Text(
                        'Configuration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Automatic Irrigation'),
                    value: irrigationAuto,
                    onChanged: (value) {
                      setState(() {
                        irrigationAuto = value!;
                      });
                    },
                  ),
                  if (irrigationAuto) ...[
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Start Time'),
                      subtitle: Text(
                        '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}',
                      ),
                      onTap: () async {
                        startTime = await showTimePicker(
                              context: context,
                              initialTime: startTime,
                            ) ??
                            startTime;
                        setState(() {});
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('End Time'),
                      subtitle: Text(
                        '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}',
                      ),
                      onTap: () async {
                        endTime = await showTimePicker(
                              context: context,
                              initialTime: endTime,
                            ) ??
                            endTime;
                        setState(() {});
                      },
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(items[index]['imageUrl']),
                      title: Text(items[index]['title']),
                      subtitle: Text(items[index]['subtitle']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: items[index]['switchValue'],
                            onChanged: (bool value) {
                              setState(() {
                                items[index]['switchValue'] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton.icon(
                          onPressed: () => _showConfigurationModal(),
                          label: const Text('Configuration'),
                          icon: const Icon(Icons.settings),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

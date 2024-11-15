import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<DataPointHumidity> humidityData = [
      DataPointHumidity(hour: 12, humidity: 76),
      DataPointHumidity(hour: 13, humidity: 77),
      DataPointHumidity(hour: 14, humidity: 74),
      DataPointHumidity(hour: 15, humidity: 65),
      DataPointHumidity(hour: 16, humidity: 54),
      DataPointHumidity(hour: 17, humidity: 62),
    ];
    List<DataPointTemp> temperatureData = [
      DataPointTemp(hour: 12, temperature: 20.19),
      DataPointTemp(hour: 13, temperature: 20.31),
      DataPointTemp(hour: 14, temperature: 21.13),
      DataPointTemp(hour: 15, temperature: 21.13),
      DataPointTemp(hour: 16, temperature: 22.63),
      DataPointTemp(hour: 17, temperature: 21.19),
    ];
    List<DataPointDP> dpData = [
      DataPointDP(hour: 12, dp: 20.19),
      DataPointDP(hour: 13, dp: 20.31),
      DataPointDP(hour: 14, dp: 21.13),
      DataPointDP(hour: 15, dp: 21.13),
      DataPointDP(hour: 16, dp: 22.63),
      DataPointDP(hour: 17, dp: 21.19),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Card(
                  elevation: 4.0,
                  child: SizedBox(
                    width: 700,
                    height: 200,
                    child: SfCartesianChart(
                      primaryXAxis: NumericAxis(
                        title: AxisTitle(
                            text: 'Hours',
                            textStyle: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                            )),
                        minimum: 12,
                        maximum: 17,
                        interval: 1,
                      ),
                      legend: Legend(
                        isVisible: true,
                      ),
                      series: <SplineSeries>[
                        SplineSeries<DataPointHumidity, int>(
                          name: 'Humidity',
                          dataSource: humidityData,
                          splineType: SplineType.clamped,
                          xValueMapper: (DataPointHumidity point, _) => point.hour,
                          yValueMapper: (DataPointHumidity point, _) => point.humidity,
                        ),
                        SplineSeries<DataPointTemp, double>(
                          name: 'Temperature',
                          dataSource: temperatureData,
                          splineType: SplineType.clamped,
                          xValueMapper: (DataPointTemp point, _) => point.hour,
                          yValueMapper: (DataPointTemp point, _) => point.temperature,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4.0,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: SfRadialGauge(
                          animationDuration: 2500,
                          enableLoadingAnimation: true,
                          title: const GaugeTitle(text: 'Pressure'),
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 150,
                              maximum: 2000,
                              axisLabelStyle: const GaugeTextStyle(
                                fontSize: 8,
                              ),
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.1,
                                thicknessUnit: GaugeSizeUnit.factor,
                                gradient: SweepGradient(
                                  colors: <Color>[Colors.blue, Colors.blueAccent],
                                  stops: <double>[0.25, 0.75],
                                ),
                              ),
                              pointers: const <GaugePointer>[
                                NeedlePointer(
                                  value: 1006.82,
                                  needleStartWidth: 1,
                                  needleEndWidth: 4,
                                  knobStyle: KnobStyle(
                                      knobRadius: 10,
                                      sizeUnit: GaugeSizeUnit.logicalPixel,
                                      color: Colors.blue),
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: const Text('1006.82 hPa',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.9),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 4.0,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: SfRadialGauge(
                          animationDuration: 2500,
                          enableLoadingAnimation: true,
                          title: const GaugeTitle(text: 'Wind Speed'),
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 30,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 60,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10),
                                GaugeRange(
                                    startValue: 60,
                                    endValue: 100,
                                    color: Colors.red,
                                    startWidth: 10,
                                    endWidth: 10),
                              ],
                              axisLabelStyle: const GaugeTextStyle(
                                fontSize: 8,
                              ),
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.1,
                                thicknessUnit: GaugeSizeUnit.factor,
                                gradient: SweepGradient(
                                  colors: <Color>[Colors.blue, Colors.blueAccent],
                                  stops: <double>[0.25, 0.75],
                                ),
                              ),
                              pointers: const <GaugePointer>[
                                NeedlePointer(
                                  value: 4,
                                  needleStartWidth: 1,
                                  needleEndWidth: 4,
                                  knobStyle: KnobStyle(
                                      knobRadius: 10,
                                      sizeUnit: GaugeSizeUnit.logicalPixel,
                                      color: Colors.greenAccent),
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: const Text('4.0 mph',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.9),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 4.0,
                child: SizedBox(
                  width: 700,
                  height: 200,
                  child: SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'Hours',
                          textStyle: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12,
                          )),
                      minimum: 12,
                      maximum: 17,
                      interval: 1,
                    ),
                    legend: Legend(
                      isVisible: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataPointHumidity {
  final int hour;
  final int humidity;
  DataPointHumidity({required this.hour, required this.humidity});
}

class DataPointTemp {
  final double hour;
  final double temperature;
  DataPointTemp({required this.hour, required this.temperature});
}

class DataPointDP {
  final double hour;
  final double dp;
  DataPointDP({required this.hour, required this.dp});
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeightData {
  WeightData(this.day, this.sales);
  final String day;
  final double sales;
}

class CalorieData {
  CalorieData(this.day, this.calories);
  final String day;
  final double calories;
}

class MacroBalanceData {
  MacroBalanceData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

ButtonStyle rounded(int index, int selectedIndex) {
  return TextButton.styleFrom(
    backgroundColor: index == selectedIndex ? Colors.black : Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}

TextStyle whiteBlack(int index, int selectedIndex) {
  return TextStyle(color: index == selectedIndex ? Colors.white : Colors.black);
}

class UserViewProgress extends StatelessWidget {
  const UserViewProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt selected = 0.obs;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ],
            ),

            SfCartesianChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Weight Tracker'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  SplineAreaSeries<WeightData, String>(
                      borderWidth: 5,
                      borderColor: Color(0xFF62e998),
                      gradient: LinearGradient(
                        stops: [
                          0.0,
                          1,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF62e998).withOpacity(0.0),
                          Color(0xFF62e998),
                        ],
                      ),
                      name: 'Weight',
                      dataSource: [
                        WeightData('Mon', 0),
                        WeightData('Tue', 5),
                        WeightData('Wed', 10),
                        WeightData('Thu', 5),
                        WeightData('Fri', 15),
                        WeightData('Sat', 5),
                        WeightData('Sun', 15)
                      ],
                      splineType: SplineType.natural,
                      cardinalSplineTension: 0.5,
                      xValueMapper: (WeightData sales, _) => sales.day,
                      yValueMapper: (WeightData sales, _) => sales.sales)
                ]),
            SfCartesianChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Calorie Intake'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  LineSeries<CalorieData, String>(
                      name: 'Recommended',
                      color: Color(0xFF62e998),
                      width: 5,
                      dataSource: [
                        CalorieData('Mon', 1500),
                        CalorieData('Tue', 2000),
                        CalorieData('Wed', 2200),
                        CalorieData('Thu', 2600),
                        CalorieData('Fri', 1500),
                        CalorieData('Sat', 1800),
                        CalorieData('Sun', 2000)
                      ],
                      xValueMapper: (CalorieData cd, _) => cd.day,
                      yValueMapper: (CalorieData cd, _) => cd.calories),
                  LineSeries<CalorieData, String>(
                      name: 'Average',
                      color: Color(0xff007eff),
                      width: 5,
                      dataSource: [
                        CalorieData('Mon', 2500),
                        CalorieData('Tue', 1000),
                        CalorieData('Wed', 1200),
                        CalorieData('Thu', 1600),
                        CalorieData('Fri', 1800),
                        CalorieData('Sat', 1500),
                        CalorieData('Sun', 1800)
                      ],
                      xValueMapper: (CalorieData cd, _) => cd.day,
                      yValueMapper: (CalorieData cd, _) => cd.calories),
                ]),
            SfCircularChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                title: ChartTitle(text: 'Macro Balance'),
                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<MacroBalanceData, String>(
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          color: Colors.white,
                          labelPosition: ChartDataLabelPosition.inside),
                      dataSource: [
                        MacroBalanceData('Carb', 25, Color(0xff74d1a9)),
                        MacroBalanceData('Proteins', 38, Color(0xff7299e5)),
                        MacroBalanceData('Fat', 34, Color(0xfff1a147)),
                      ],
                      pointColorMapper: (MacroBalanceData data, _) =>
                          data.color,
                      xValueMapper: (MacroBalanceData data, _) => data.x,
                      yValueMapper: (MacroBalanceData data, _) => data.y)
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => TextButton(
                    style: rounded(0, selected.value),
                    onPressed: () {
                      selected.value = 0;
                    },
                    child:
                        Text('Waist', style: whiteBlack(0, selected.value)))),
                Obx(() => TextButton(
                    style: rounded(1, selected.value),
                    onPressed: () {
                      selected.value = 1;
                    },
                    child: Text('Hit', style: whiteBlack(1, selected.value)))),
                Obx(() => TextButton(
                    style: rounded(2, selected.value),
                    onPressed: () {
                      selected.value = 2;
                    },
                    child:
                        Text('Chest', style: whiteBlack(2, selected.value)))),
                Obx(() => TextButton(
                    style: rounded(3, selected.value),
                    onPressed: () {
                      selected.value = 3;
                    },
                    child: Text('Neck', style: whiteBlack(3, selected.value)))),
                Obx(() => TextButton(
                    style: rounded(4, selected.value),
                    onPressed: () {
                      selected.value = 4;
                    },
                    child: Text('Upper Arm',
                        style: whiteBlack(4, selected.value)))),
              ],
            ),
            SfCartesianChart(
                legend:
                    Legend(isVisible: true, position: LegendPosition.bottom),
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  SplineAreaSeries<WeightData, String>(
                      borderWidth: 5,
                      borderColor: Color(0xfff1a147),
                      gradient: LinearGradient(
                        stops: [
                          0.0,
                          1,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xfff1a147).withOpacity(0.0),
                          Color(0xfff1a147),
                        ],
                      ),
                      name: 'Weight',
                      dataSource: [
                        WeightData('Mon', 0),
                        WeightData('Tue', 5),
                        WeightData('Wed', 10),
                        WeightData('Thu', 5),
                        WeightData('Fri', 15),
                        WeightData('Sat', 5),
                        WeightData('Sun', 15)
                      ],
                      splineType: SplineType.natural,
                      cardinalSplineTension: 0.5,
                      xValueMapper: (WeightData sales, _) => sales.day,
                      yValueMapper: (WeightData sales, _) => sales.sales)
                ]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BMI (Average)'),
                  Text('21.6'),
                ],
              ),
            ),
            SfLinearGauge(
                showLabels: false,
                showTicks: false,
                minimum: 0, maximum: 60,
              markerPointers: [
                LinearWidgetPointer(
                  value: 21.6,
                  position: LinearElementPosition.outside,
                  markerAlignment: LinearMarkerAlignment.center,
                  child: Container(
                      height: 32,
                      width: 32,
                      child: Card(
                          color: Colors.grey.shade800,
                        elevation: 8,
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                        ),
                      ),

                  ),
                ),
              ],
              ranges: [
                LinearGaugeRange(
                  startWidth: 16,
                    endWidth: 16,
                    startValue: 0,
                    endValue: 60,
                    shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                          Colors.red,
                        ]).createShader(bounds))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

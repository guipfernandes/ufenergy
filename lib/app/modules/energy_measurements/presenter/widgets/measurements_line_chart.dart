import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ufenergy/app/core/utils/double_utils.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';

class MeasurementLineChart extends StatefulWidget {
  final List<EnergyMeasurementEntity> energyMeasurements;

  const MeasurementLineChart({Key? key, required this.energyMeasurements}) : super(key: key);

  @override
  _MeasurementLineChartState createState() => _MeasurementLineChartState();
}

class _MeasurementLineChartState extends State<MeasurementLineChart> {
  List<Color> gradientColors = [
    const Color(0xFF6AB4F7),
    const Color(0xff02d39a),
  ];

  late double maxActivePower;

  @override
  void initState() {
    super.initState();
    maxActivePower = getMaxActivePower();
  }

  double getMaxActivePower() {
    List<double> activePowers = widget.energyMeasurements.map((e) => e.activePower).toList();
    return activePowers.length > 0 ? activePowers.reduce(max) : 5;
  }

  double getMaxChartY() {
    return (maxActivePower * 1.4).roundToNextEndingWithZero();
  }

  double getMaxChartX() {
    return widget.energyMeasurements.length.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(measurementLineChartData());
  }

  LineChartData measurementLineChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 0.4,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 0.4,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: getMaxChartX()/10,
          getTextStyles: (context, value) => const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            if (value == 0) return "${widget.energyMeasurements[0].date.hour} h";
            if (value == getMaxChartX() / 2) return "${widget.energyMeasurements[widget.energyMeasurements.length ~/ 2].date.hour} h";
            if (value.toInt() == getMaxChartX().toInt()) return "${widget.energyMeasurements[widget.energyMeasurements.length - 1].date.hour} h";
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: getMaxChartY()/10,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value == 0) return "0 kW";
            if (value == getMaxChartY() / 2) return "${getMaxChartY() ~/ 2} kW";
            if (value.toInt() == getMaxChartY().toInt()) return "${getMaxChartY().toInt()} kW";
            return '';
          },
          reservedSize: 45,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: getMaxChartX(),
      minY: 0,
      maxY: getMaxChartY(),
      lineBarsData: [
        LineChartBarData(
          spots: buildChartSpots(),
          isCurved: false,
          colors: gradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot>? buildChartSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < widget.energyMeasurements.length; i++) {
      EnergyMeasurementEntity measurement = widget.energyMeasurements[i];
      spots.add(FlSpot(i.toDouble(), double.parse(measurement.activePower.toStringAsFixed(2))));
    }
    return spots;
  }
}

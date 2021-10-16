import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:ufenergy/app/modules/energy_measurements/domain/entities/energy_measurement_entity.dart';
import 'package:ufenergy/app/modules/energy_measurements/presenter/controller/energy_measurements_controller.dart';

class MeasurementLineChart extends StatefulWidget {
  final List<EnergyMeasurementEntity> energyMeasurements;

  const MeasurementLineChart({Key? key, required this.energyMeasurements}) : super(key: key);

  @override
  _MeasurementLineChartState createState() => _MeasurementLineChartState();
}

class _MeasurementLineChartState extends State<MeasurementLineChart> {
  final controller = Modular.get<EnergyMeasurementsController>();

  double minX = 0;
  double maxX = 0;
  double minY = 0;
  double maxY = 0;
  double leftTitlesInterval = 0;
  double bottomTitlesInterval = 0;

  final int divider = 25;
  final int leftLabelsCount = 6;

  List<FlSpot> spots = const [];

  final List<Color> gradientColors = [
    const Color(0xFF6AB4F7),
    const Color(0xff02d39a),
  ];

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  void _prepareData() async {
    if (widget.energyMeasurements.isNotEmpty) {
      double _minY = double.maxFinite;
      double _maxY = double.minPositive;

      spots = widget.energyMeasurements.map((energyMeter) {
        if (_minY > energyMeter.activePower) _minY = energyMeter.activePower;
        if (_maxY < energyMeter.activePower) _maxY = energyMeter.activePower;
        return FlSpot(
          energyMeter.date.millisecondsSinceEpoch.toDouble(),
          double.parse(energyMeter.activePower.toStringAsFixed(2)),
        );
      }).toList();

      minX = controller.dateStartFilter.millisecondsSinceEpoch.toDouble();
      maxX = controller.dateEndFilter.millisecondsSinceEpoch.toDouble();
      minY = (_minY / divider).floorToDouble() * divider;
      maxY = (_maxY / divider).ceilToDouble() * divider;
      leftTitlesInterval = ((maxY - minY) / (leftLabelsCount - 1)).floorToDouble();

      int diffDays = controller.dateEndFilter.difference(controller.dateStartFilter).inDays;
      bottomTitlesInterval =  ((maxX - minX) / (diffDays > leftLabelsCount ? (leftLabelsCount - 1) : diffDays.toDouble())).floorToDouble();

    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.energyMeasurements.isNotEmpty
        ? LineChart(measurementLineChartData())
        : Center(
            child: Text(
            "Nenhuma medição foi encontrada.",
            style: TextStyle(fontSize: 16.0),
          ));
  }

  LineChartData measurementLineChartData() {
    return LineChartData(
      gridData: buildGridData(),
      titlesData: buildTitlesData(),
      borderData: buildBorderData(),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      clipData: FlClipData.all(),
      lineBarsData: buildLinesBarData(),
      lineTouchData: buildLineTouchData(),
    );
  }

  FlGridData? buildGridData() {
    return FlGridData(
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
    );
  }

  FlBorderData? buildBorderData() {
    return FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 0.5)
    );
  }

  FlTitlesData? buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: true, getTitles: (value) => ""),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: buildBottomTitles(),
      leftTitles: buildLeftTitles(),
    );
  }

  SideTitles? buildBottomTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 22,
      interval: bottomTitlesInterval == 0 ? 1 : bottomTitlesInterval,
      getTextStyles: (context, value) => const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 12),
      getTitles: (value) {
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return DateFormat.MMMd('pt').format(date);
      },
      margin: 8,
    );
  }

  SideTitles? buildLeftTitles() {
    return SideTitles(
      showTitles: true,
      interval: leftTitlesInterval == 0 ? 1 : leftTitlesInterval,
      getTextStyles: (context, value) => const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      getTitles: (value) => "${value.toInt()} kWh",
      reservedSize: 45,
      margin: 10,
    );
  }

  List<LineChartBarData>? buildLinesBarData() {
    return [
      LineChartBarData(
        spots: spots,
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
    ];
  }

  LineTouchData? buildLineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.shade600,
          maxContentWidth: 200,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((flSpot) {
              return LineTooltipItem(
                "Potência Ativa: ${flSpot.y.toString()} kWh\n",
                const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "${DateFormat.yMd('pt').add_Hm().format(DateTime.fromMillisecondsSinceEpoch(flSpot.x.toInt()))}",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              );
            }).toList();
          }),
    );
  }
}

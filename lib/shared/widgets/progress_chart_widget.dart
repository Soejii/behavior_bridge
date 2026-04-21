import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

class ProgressChartWidget extends StatelessWidget {
  const ProgressChartWidget({
    super.key,
    required this.values,
    required this.goal,
    this.height = 180,
    this.scheduleChanges = const <int>[],
  });

  final List<int> values;
  final int goal;
  final double height;
  final List<int> scheduleChanges;

  @override
  Widget build(BuildContext context) {
    final b = context.brand;
    if (values.isEmpty) {
      return SizedBox(
        height: height.h,
        child: Center(
          child: Text(
            'No data yet',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
              color: b.ink3,
            ),
          ),
        ),
      );
    }

    final maxY = ([...values, goal + 1].reduce((a, b) => a > b ? a : b)) + 0.5;
    final spots = [
      for (var i = 0; i < values.length; i++)
        FlSpot(i.toDouble(), values[i].toDouble()),
    ];

    return SizedBox(
      height: height.h,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (values.length - 1).toDouble(),
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2,
            getDrawingHorizontalLine: (_) => FlLine(
              color: b.line,
              strokeWidth: 1,
              dashArray: const [2, 3],
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 2,
                getTitlesWidget: (v, _) => Text(
                  v.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 9.sp,
                    color: b.ink4,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 18,
                interval: (values.length / 5).clamp(1, 7).toDouble(),
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  final label = i == values.length - 1 ? 'today' : 'd${i + 1}';
                  return Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 9.sp,
                        color: b.ink4,
                      ),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(show: false),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: goal.toDouble(),
                color: b.ok,
                strokeWidth: 1.4,
                dashArray: const [5, 4],
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topRight,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 10.sp,
                    color: b.okDark,
                    fontWeight: FontWeight.w600,
                  ),
                  labelResolver: (_) => 'goal',
                ),
              ),
            ],
            verticalLines: [
              for (final idx in scheduleChanges)
                VerticalLine(
                  x: idx.toDouble(),
                  color: b.accent,
                  strokeWidth: 1,
                  dashArray: const [3, 3],
                ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: b.accent,
              barWidth: 1.8,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    b.accent.withOpacity(0.22),
                    b.accent.withOpacity(0.02),
                  ],
                ),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) {
                  final isLast = spot.x.toInt() == values.length - 1;
                  final color = spot.y >= goal ? b.ok : b.warn;
                  return FlDotCirclePainter(
                    radius: isLast ? 3.2 : 2.4,
                    color: color,
                    strokeWidth: 1.2,
                    strokeColor: b.card,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

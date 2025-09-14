import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class WeeklyMinutesBarChart extends StatelessWidget {
  final List<int> minutes;
  final Color barColor;
  final Color backgroundColor;
  final double barWidth;
  final double borderRadius;
  WeeklyMinutesBarChart({
    super.key,
    required this.minutes,
    this.barColor = AppColors.primary,
    this.backgroundColor = AppColors.secondary,
    this.barWidth = 18,
    this.borderRadius = 14,
  }) : assert(minutes.length == 7, 'Minutes list must have 7 values (Sun-Sat)');

  static const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    final maxMin = (minutes.reduce((a, b) => a > b ? a : b)).toDouble();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: AppColors.shadowColor,
          )
        ],
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(enabled: false),
            maxY: (maxMin * 1.2).clamp(10, 120),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 36,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i >= _days.length) return const SizedBox();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _days[i],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${minutes[i]} min',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            barGroups: List.generate(minutes.length, (i) {
              return BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    toY: minutes[i].toDouble(),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(borderRadius),
                    ),
                    width: barWidth,
                    color: barColor,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: (maxMin * 1.05),
                      color: backgroundColor,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class DayWiseMinutesBarChart extends StatelessWidget {
  final List<int> minutes;
  final List<String> days; // <-- changed here
  final Color barColor;
  final Color backgroundColor;
  final double barWidth;
  final double borderRadius;

  const DayWiseMinutesBarChart({
    super.key,
    required this.minutes,
    required this.days, // <-- required
    this.barColor = AppColors.primary,
    this.backgroundColor = AppColors.secondary,
    this.barWidth = 18,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    if (minutes.isEmpty || days.isEmpty) {
      return const Center(child: Text("No data found"));
    }

    final maxMin = minutes.reduce((a, b) => a > b ? a : b).toDouble();
    final visualMax = 100.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
            maxY: visualMax,
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
                    final index = value.toInt();
                    if (index < 0 || index >= minutes.length) return const SizedBox();

                    return Column(
                      children: [
                        Text(
                          days[index],
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${minutes[index]} min',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
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
                barsSpace: 4.w,
                barRods: [
                  BarChartRodData(
                    toY: minutes[i].toDouble(), // <-- make the bar height dynamic
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(borderRadius.r),
                    ),
                    width: barWidth.w,
                    color: barColor,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: visualMax,
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

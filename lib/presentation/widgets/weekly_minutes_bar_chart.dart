import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class WeeklyMinutesBarChart extends StatelessWidget {
  final List<int> minutes;
  final Color barColor;
  final Color backgroundColor;
  final double barWidth;
  final double borderRadius;
  const WeeklyMinutesBarChart({
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
    final visualMax = 100.0; // Maximum visual bar height (100%)

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
                  reservedSize: 36.h,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i >= _days.length) return const SizedBox();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _days[i],
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${minutes[i]} min',
                          style: TextStyle(
                            fontSize: 10.sp,
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
              final visualValue = (minutes[i] / maxMin * visualMax).clamp(0, visualMax);
              return BarChartGroupData(
                x: i,
                barsSpace: 4.w,
                barRods: [
                  BarChartRodData(
                    toY: visualValue.toDouble(),
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

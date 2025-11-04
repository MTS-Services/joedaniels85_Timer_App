import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final String hintText;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final TimeOfDay? initialTime;

  const CustomTimePicker({
    super.key,
    this.hintText = "-- : -- --",
    required this.onTimeSelected,
    this.initialTime,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  void _showTimePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        int hour = selectedTime?.hourOfPeriod ?? 1;
        int minute = selectedTime?.minute ?? 0;
        String period =
        (selectedTime?.period == DayPeriod.pm) ? 'PM' : 'AM';

        return Dialog(
          backgroundColor: const Color(0xFF2D2D2D),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: StatefulBuilder(
            builder: (context, setInnerState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Time Picker Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScrollPicker(
                          start: 1,
                          end: 12,
                          selected: hour,
                          onSelected: (val) =>
                              setInnerState(() => hour = val),
                        ),
                        _buildScrollPicker(
                          start: 0,
                          end: 59,
                          selected: minute,
                          onSelected: (val) =>
                              setInnerState(() => minute = val),
                        ),
                        _buildAmPmPicker(
                          selected: period,
                          onSelected: (val) =>
                              setInnerState(() => period = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        final time = TimeOfDay(
                          hour: period == 'PM'
                              ? (hour % 12) + 12
                              : hour % 12,
                          minute: minute,
                        );
                        setState(() => selectedTime = time);
                        widget.onTimeSelected(time);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildScrollPicker({
    required int start,
    required int end,
    required int selected,
    required ValueChanged<int> onSelected,
  }) {
    return SizedBox(
      height: 100,
      width: 50,
      child: ListWheelScrollView.useDelegate(
        perspective: 0.005,
        diameterRatio: 1.2,
        itemExtent: 35,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onSelected(start + index),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index + start > end) return null;
            final val = (index + start).toString().padLeft(2, '0');
            return Center(
              child: Text(
                val,
                style: TextStyle(
                  color: val == selected.toString().padLeft(2, '0')
                      ? Colors.teal
                      : Colors.white70,
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAmPmPicker({
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ['AM', 'PM'].map((period) {
        final isSelected = period == selected;
        return GestureDetector(
          onTap: () => onSelected(period),
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              period,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTimePickerDialog,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime == null
                  ? widget.hintText
                  : "${selectedTime!.hourOfPeriod.toString().padLeft(2, '0')} : ${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period == DayPeriod.am ? 'AM' : 'PM'}",
              style: const TextStyle(color: Colors.teal, fontSize: 16),
            ),
            const Icon(Icons.access_time, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}

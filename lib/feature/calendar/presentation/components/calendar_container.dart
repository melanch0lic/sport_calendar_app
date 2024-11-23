import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/upcoming_competitons_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({super.key});

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  int _selectedRangeIndex = -1;
  PickerDateRange _selectedRange = const PickerDateRange(null, null);
  final DateRangePickerController _datePickerController = DateRangePickerController();
  PickerDateRange _tempSelectedRange = PickerDateRange(DateTime.now(), DateTime.now());
  void _setRange(int months, int index) {
    final startDate = DateTime.now();
    final endDate = startDate.add(Duration(days: months * 30));
    setState(() {
      if (_selectedRangeIndex == index) {
        _selectedRangeIndex = -1;
        _tempSelectedRange = const PickerDateRange(null, null);
      } else {
        _tempSelectedRange = PickerDateRange(startDate, endDate);
        _selectedRangeIndex = index;
      }
    });
  }

  void _resetRange() {
    setState(() {
      _selectedRange = const PickerDateRange(null, null);
      _tempSelectedRange = const PickerDateRange(null, null);
      _selectedRangeIndex = -1;
      Future.delayed(Duration.zero, () {
        _datePickerController.selectedRanges = null;
        _datePickerController.selectedRange = null;
        _datePickerController.selectedRanges = null;
        _datePickerController.selectedDates = null;
        _datePickerController.selectedDate = null;
      });
    });
  }

  void _applyRange() {
    setState(() {
      _selectedRange = _tempSelectedRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: const Color.fromRGBO(236, 239, 243, 1)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _setRange(1, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          color: _selectedRangeIndex == 0
                              ? const Color.fromRGBO(239, 246, 255, 1)
                              : const Color.fromRGBO(236, 239, 243, 1),
                          border: _selectedRangeIndex == 0
                              ? Border.all(color: const Color.fromRGBO(67, 84, 250, 1))
                              : const Border()),
                      child: Center(
                        child: Text(
                          '1 месяц',
                          style: CommonTextStyles()
                              .buttonText
                              .copyWith(color: _selectedRangeIndex == 0 ? const Color.fromRGBO(67, 84, 250, 1) : null),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _setRange(3, 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          color: _selectedRangeIndex == 1
                              ? const Color.fromRGBO(239, 246, 255, 1)
                              : const Color.fromRGBO(236, 239, 243, 1),
                          border: _selectedRangeIndex == 1
                              ? Border.all(color: const Color.fromRGBO(67, 84, 250, 1))
                              : const Border()),
                      child: Center(
                        child: Text(
                          '3 месяца',
                          style: CommonTextStyles()
                              .buttonText
                              .copyWith(color: _selectedRangeIndex == 1 ? const Color.fromRGBO(67, 84, 250, 1) : null),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _setRange(6, 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          color: const Color.fromRGBO(236, 239, 243, 1),
                          border: _selectedRangeIndex == 2
                              ? Border.all(
                                  color: _selectedRangeIndex == 2
                                      ? const Color.fromRGBO(67, 84, 250, 1)
                                      : const Color.fromRGBO(236, 239, 243, 1),
                                )
                              : const Border()),
                      child: Center(
                        child: Text(
                          '6 месяцев',
                          style: CommonTextStyles()
                              .buttonText
                              .copyWith(color: _selectedRangeIndex == 2 ? const Color.fromRGBO(67, 84, 250, 1) : null),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SfDateRangePicker(
            controller: _datePickerController,
            todayHighlightColor: const Color.fromRGBO(87, 84, 250, 1),
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Colors.white,
              textStyle: CommonTextStyles().title2.copyWith(fontSize: 20),
            ),
            selectionTextStyle: CommonTextStyles().cardBody,
            rangeTextStyle: CommonTextStyles().cardBody,
            backgroundColor: Colors.white,
            startRangeSelectionColor: const Color.fromRGBO(87, 84, 250, 1),
            rangeSelectionColor: const Color.fromRGBO(87, 84, 250, 1),
            endRangeSelectionColor: const Color.fromRGBO(87, 84, 250, 1),
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                _tempSelectedRange = args.value;
              });
            },
            initialSelectedDate: DateTime.now(),
            initialSelectedRange: _tempSelectedRange,
            monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: CommonTextStyles().cardBody.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(107, 110, 117, 1),
                    ),
              ),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: CommonTextStyles().cardBody.copyWith(
                    color: const Color.fromRGBO(29, 31, 36, 1),
                  ),
              weekendTextStyle: CommonTextStyles().cardBody.copyWith(
                    color: const Color.fromRGBO(255, 82, 71, 1),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _resetRange,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: const Color.fromRGBO(211, 213, 218, 1)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Сбросить',
                          style: CommonTextStyles().title2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _applyRange,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color.fromRGBO(67, 84, 250, 1),
                      ),
                      child: Center(
                        child: Text(
                          'Применить',
                          style: CommonTextStyles().title2.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${formatTimestamp(_selectedRange.startDate?.toLocal().toString() ?? DateTime.now().toString())} - ${formatTimestamp(
              _selectedRange.endDate?.toLocal().toString() ?? DateTime.now().toString(),
            )}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

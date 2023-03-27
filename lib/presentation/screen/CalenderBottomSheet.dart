

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderBottomSheet extends StatefulWidget {

    Function callback;
   CalenderBottomSheet({Key? key ,required this.callback}) : super(key: key);

  @override
  State<CalenderBottomSheet> createState() => _CalenderBottomSheetState();
}

class _CalenderBottomSheetState extends State<CalenderBottomSheet> {


  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _focusedDay ;
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],

      height: MediaQuery.of(context).size.height/2,
      child:  TableCalendar(
        // calendarStyle: CalendarStyle(
        //     outsideTextStyle: TextStyle(color: Colors.white),
        //     todayTextStyle: TextStyle(color: Colors.white),
        //
        // ),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay??DateTime.now(),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {


          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = selectedDay;
              widget.callback(selectedDay);
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

      ),
    );

  }
}

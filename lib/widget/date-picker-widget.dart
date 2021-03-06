import 'package:flutter/material.dart';

typedef OnSelectedDate();
const int lengthOfMonth = 12;

class DatePicker extends StatefulWidget {
  DatePicker({
    DateTime initDateTime,
    this.itemHeight = 50,
    this.diameterRatio = 3,
    this.magnification = 1.2,
    this.useMagnifier = true,
    this.isVisibleDay = true,
    this.lengthOfYear = 100,
  }) : this.initDateTime = initDateTime ?? DateTime.now(),
  this.initialYearIndex = lengthOfYear ~/ 2;

  final DateTime initDateTime;
  final double itemHeight;
  final double diameterRatio;
  final double magnification;
  final bool useMagnifier;
  final bool isVisibleDay;
  final int lengthOfYear;
  final int initialYearIndex;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  FixedExtentScrollController _yearScrollController;
  FixedExtentScrollController _monthScrollController;
  FixedExtentScrollController _dayScrollController;
  int _selectedYear;
  int _selectedMonth;
  int _selectedDay;

  @override
  void initState() {
    _selectedYear = widget.initDateTime.year;
    _selectedMonth = widget.initDateTime.month;
    _selectedDay = widget.initDateTime.day;
    _yearScrollController = FixedExtentScrollController(initialItem: widget.initialYearIndex);
    _monthScrollController = FixedExtentScrollController(initialItem: _selectedMonth - 1);
    _dayScrollController = FixedExtentScrollController(initialItem: _selectedDay - 1);
    super.initState();
  }

  @override
  void dispose() {
    _yearScrollController?.dispose();
    _monthScrollController?.dispose();
    _dayScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 25,
                bottom: 25
              ),
              child: Row(
                children: [
                  _buildYearPicker(),
                  _buildMonthPicker(),
                  _buildDayPicker()
                ],
              ),
            ),
          ),
          _bottomButtons(),
        ],
      ),
    );
  }

  _buildYearPicker() {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if(notification is ScrollEndNotification) {
            setState(() {});
          }
          return true;
        },
        child: ListWheelScrollView.useDelegate(
          physics: const FixedExtentScrollPhysics(),
          controller: _yearScrollController,
          itemExtent: widget.itemHeight,
          diameterRatio: widget.diameterRatio,
          useMagnifier: widget.useMagnifier,
          magnification: widget.magnification,
          onSelectedItemChanged: (index) {
            _selectedYear += index - widget.initialYearIndex;
          },
          childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(widget.lengthOfYear, (index) =>
                  Center(
                    child: Text(
                      (_selectedYear - widget.initialYearIndex + index).toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  )
              )
          ),
        ),
      ),
    );
  }

  _buildMonthPicker() {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if(notification is ScrollEndNotification) {
            setState(() {});
          }
          return true;
        },
        child: ListWheelScrollView.useDelegate(
          physics: const FixedExtentScrollPhysics(),
          controller: _monthScrollController,
          itemExtent: widget.itemHeight,
          diameterRatio: widget.diameterRatio,
          useMagnifier: widget.useMagnifier,
          magnification: widget.magnification,
          onSelectedItemChanged: (index) {
            _selectedMonth = index + 1;
          },
          childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(lengthOfMonth, (index) =>
                  Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  )
              )
          ),
        ),
      ),
    );
  }

  _buildDayPicker() {
    final int dayOfMonth = _dayOfMonth;

    return Expanded(
      child: ListWheelScrollView.useDelegate(
        physics: const FixedExtentScrollPhysics(),
        controller: _dayScrollController,
        itemExtent: widget.itemHeight,
        diameterRatio: widget.diameterRatio,
        useMagnifier: widget.useMagnifier,
        magnification: widget.magnification,
        onSelectedItemChanged: (index) {
          _selectedDay = index + 1;
        },
        childDelegate: ListWheelChildLoopingListDelegate(
            children: List.generate(dayOfMonth, (index) =>
                Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                )
            )
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                '취소',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                ),
              )
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.white,
          ),
          FlatButton(
              onPressed: () {},
              child: Text(
                '완료',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
                ),
              )
          ),
        ],
      ),
    );
  }

  int get _dayOfMonth => DateTime(_selectedYear, _selectedMonth + 1, 0).day;
}

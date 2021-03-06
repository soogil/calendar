import 'package:calendar/widget/date-picker-widget.dart';
import 'package:flutter/material.dart';

class PickerDialog {
  PickerDialog();

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => DatePicker());
  }
}
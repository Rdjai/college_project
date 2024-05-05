import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DobPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String text;

  const DobPicker({Key? key, required this.onDateSelected, required this.text})
      : super(key: key);

  @override
  State<DobPicker> createState() => _DobPickerState();
}

class _DobPickerState extends State<DobPicker> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16.0);
    return Row(
      children: <Widget>[
        Text('${widget.text}:', style: textStyle),
        SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(selectedDate != null
              ? DateFormat('yMMMMd').format(selectedDate!)
              : 'Select Date'),
        ),
      ],
    );
  }
}

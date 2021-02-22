import 'package:flutter/material.dart';

class CheckBoxInputField extends StatefulWidget {
  bool isSelected;
  Function onSelectChanged;
  String title;
  CheckBoxInputField(
      {@required this.title,
      @required this.onSelectChanged,
      @required this.isSelected});
  @override
  _CheckBoxInputFieldState createState() => _CheckBoxInputFieldState();
}

class _CheckBoxInputFieldState extends State<CheckBoxInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CheckboxListTile(
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black),
      ),
      value: widget.isSelected,
      onChanged: widget.onSelectChanged,
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    ));
  }
}

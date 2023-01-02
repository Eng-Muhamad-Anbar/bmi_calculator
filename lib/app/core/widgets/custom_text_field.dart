import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String myLabel;
  final String hint;
  final TextInputType textInputType;
  final TextEditingController? myController;
  final String unitLabel;
  final String? Function(String?) myValidator;
  final Function(String)? onFieldChanges;

  CustomTextField(
      {required this.myLabel,
      required this.hint,
      this.myController,
      this.unitLabel = "",
      this.textInputType = TextInputType.text,
      required this.myValidator,
      this.onFieldChanges});

  OutlineInputBorder showOutlineInputBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.purple,
        ),
        borderRadius: BorderRadius.circular(10));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              myLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            alignment: Alignment.center,
            width: 200,
            child: TextFormField(
              validator: myValidator,
              onChanged: onFieldChanges,
              controller: myController,
              keyboardType: textInputType,
              decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: const Color(0xFFEFEFEF),
                  enabledBorder: showOutlineInputBorder(),
                  focusedBorder: showOutlineInputBorder(),
                  errorBorder: showOutlineInputBorder(),
                  focusedErrorBorder: showOutlineInputBorder(),
                  disabledBorder: showOutlineInputBorder(),
                  border: showOutlineInputBorder()),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              unitLabel,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

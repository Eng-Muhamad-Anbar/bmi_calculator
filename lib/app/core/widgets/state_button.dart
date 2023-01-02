import 'package:flutter/material.dart';

class StateButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final void Function()? myOnPressed;
  const StateButton({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.myOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading ? null : myOnPressed,
        child: isLoading ? const CircularProgressIndicator() : Text(text));
  }
}

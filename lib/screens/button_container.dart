import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonContainer extends StatelessWidget {
  String club;
  Function() onPressed;
  ButtonContainer({required this.club, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 150.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        /*color: Colors.white30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),*/
        style: ElevatedButton.styleFrom(
            primary: Colors.white30,
            fixedSize: const Size(300, 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        child: Text(
          '$club',
          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
        ),
      ),
    );
  }
}

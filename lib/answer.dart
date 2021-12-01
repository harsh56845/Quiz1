// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

String? answerText ;
final Color? answerColor;
final Function()? answerTap;
  Color textColor = Colors.black;
  Answer({Key? key,  this.answerText, this.answerColor,this.answerTap,  required this.textColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                decoration: BoxDecoration(
                  color: answerColor,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Text(
                  answerText!,
                  style: TextStyle(fontSize: 15,color: textColor),
                ),
              ),
    );
  }
}
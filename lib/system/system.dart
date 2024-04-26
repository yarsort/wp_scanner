import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color iconColor = Color.fromRGBO(5, 130, 202, 1);

doubleToString(double sum) {
  var f = NumberFormat("##0.00", "en_US");
  return (f.format(sum).toString());
}

doubleThreeToString(double sum) {
  var f = NumberFormat("##0.000", "en_US");
  return (f.format(sum).toString());
}

shortDateToString(DateTime date) {
  // Проверка на пустую дату
  if (date == DateTime(1900, 1, 1)) {
    return '';
  }
  // Отформатируем дату
  var f = DateFormat('dd.MM.yyyy');
  return (f.format(date).toString());
}

short1CDateToString(DateTime date) {
  // Проверка на пустую дату
  if (date == DateTime(1900, 1, 1)) {
    return '';
  }
  // Отформатируем дату
  var f = DateFormat('yyyyMMdd');
  return (f.format(date).toString());
}

fullDateToString(DateTime date) {
  // Проверка на пустую дату
  if (date == DateTime(1900, 1, 1)) {
    return '';
  }
  // Отформатируем дату
  var f = DateFormat('dd.MM.yyyy HH:mm:ss');
  return (f.format(date).toString());
}

showMessage(String textMessage, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(textMessage),
      duration: const Duration(seconds: 3),
    ),
  );
}

showErrorMessage(String textMessage, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(textMessage),
      duration: const Duration(seconds: 3),
    ),
  );
}

nameGroup({String nameGroup = '', bool hideDivider = false}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameGroup,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(5, 130, 202, 1),
            fontWeight: FontWeight.bold,),
          textAlign: TextAlign.start,),
        if (!hideDivider) const Divider(),
        if (hideDivider) const SizedBox(height: 10),
      ],
    ),
  );
}


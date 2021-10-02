import 'package:flutter/material.dart';

Future<DateTime?> showDateDialog(BuildContext context, {initialDate}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
    helpText: 'Selecione a data',
    errorFormatText: 'Formato inválido',
    errorInvalidText: 'Fora do Intervalo',
    fieldLabelText: 'Digite a data',
    fieldHintText: 'dd/mm/aaaa',
    locale: const Locale('pt'),
  );

  return selectedDate;
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';
import 'adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.amber, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.white, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                label: 'Título',
              ),
              AdaptativeTextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                label: 'Valor (R\$)',
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    'Nova Transação',
                    _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

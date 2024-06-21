import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../models/calculation.dart';

class MathOperationPage extends StatefulWidget {
  final String username;

  MathOperationPage({required this.username});

  @override
  _MathOperationPageState createState() => _MathOperationPageState();
}

class _MathOperationPageState extends State<MathOperationPage> {
  final TextEditingController _operand1Controller = TextEditingController();
  final TextEditingController _operand2Controller = TextEditingController();
  String _operation = '+';
  double? _result;

  Future<void> _calculate() async {
    final operand1 = double.tryParse(_operand1Controller.text);
    final operand2 = double.tryParse(_operand2Controller.text);

    if (operand1 == null || operand2 == null) {
      return;
    }

    switch (_operation) {
      case '+':
        _result = operand1 + operand2;
        break;
      case '-':
        _result = operand1 - operand2;
        break;
      case '*':
        _result = operand1 * operand2;
        break;
      case '/':
        if (operand2 != 0) {
          _result = operand1 / operand2;
        } else {
          _result = double.nan;
        }
        break;
    }

    if (_result != null) {
      final calculation = Calculation(
        widget.username,
        _operation,
        operand1,
        operand2,
        _result!,
      );
      await userRepository.addCalculation(calculation);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Operação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _operand1Controller,
              decoration: InputDecoration(labelText: 'Operando 1'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _operand2Controller,
              decoration: InputDecoration(labelText: 'Operando 2'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _operation,
              onChanged: (String? newValue) {
                setState(() {
                  _operation = newValue!;
                });
              },
              items: <String>['+', '-', '*', '/']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Calcular'),
            ),
            if (_result != null)
              Text(
                'Resultado: $_result',
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../models/calculation.dart';

class HistoryPage extends StatelessWidget {
  final String username;

  HistoryPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Cálculos'),
      ),
      body: FutureBuilder<List<Calculation>>(
        future: userRepository.getUserCalculations(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum cálculo encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final calculation = snapshot.data![index];
                return ListTile(
                  title: Text(
                      '${calculation.operand1} ${calculation.operation} ${calculation.operand2} = ${calculation.result}'),
                  subtitle: Text('Feito por: ${calculation.username}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

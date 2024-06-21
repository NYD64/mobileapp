class Calculation {
  int? id;
  String username;
  String operation;
  double operand1;
  double operand2;
  double result;

  Calculation(
      this.username, this.operation, this.operand1, this.operand2, this.result,
      {this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'operation': operation,
      'operand1': operand1,
      'operand2': operand2,
      'result': result,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      map['username'],
      map['operation'],
      map['operand1'],
      map['operand2'],
      map['result'],
      id: map['id'],
    );
  }
}

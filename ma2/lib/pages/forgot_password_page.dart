import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _errorMessage = '';
  String _successMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text;
    final newPassword = _newPasswordController.text;

    final success =
        await userRepository.updateUserPasswordByEmail(email, newPassword);
    if (success) {
      setState(() {
        _successMessage = 'Senha alterada com sucesso';
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'E-mail não encontrado';
        _successMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueci minha senha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Nova senha'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Alterar senha'),
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              _successMessage,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

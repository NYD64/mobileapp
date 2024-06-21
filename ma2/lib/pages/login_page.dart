import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_clearErrorMessage);
    _passwordController.addListener(_clearErrorMessage);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_clearErrorMessage);
    _passwordController.removeListener(_clearErrorMessage);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearErrorMessage() {
    setState(() {
      _errorMessage = '';
    });
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final isAuthenticated =
        await userRepository.authenticate(username, password);
    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)),
      );
    } else {
      setState(() {
        _errorMessage = 'Nome de usuário ou senha incorretos';
      });
    }
  }

  void _navigateToRegister() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
    setState(() {
      _errorMessage = '';
    });
  }

  void _navigateToForgotPassword() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nome de usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _navigateToRegister,
              child: Text('Registrar-se'),
            ),
            TextButton(
              onPressed: _navigateToForgotPassword,
              child: Text('Esqueci minha senha'),
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

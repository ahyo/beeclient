import 'package:client/components/custom_button.dart';
import 'package:client/components/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 18, 32, 47),
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/images/header.png'),
          //       fit: BoxFit.cover),
          // ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: kIsWeb ? _buildWebLayout() : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/image.png',
              height: 400,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildLoginForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLoginForm(),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomInputField(
          controller: _usernameController,
          labelText: 'Username',
          prefixIcon: const Icon(Icons.person),
        ),
        CustomInputField(
          controller: _passwordController,
          labelText: 'Password',
          obscureText: _obscurePassword,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Login',
          icon: const Icon(Icons.login),
          onPressed: () async {
            final username = _usernameController.text.trim();
            final password = _passwordController.text.trim();

            if (username.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Username and password cannot be empty')),
              );
              return;
            }

            bool success =
                await Provider.of<AuthProvider>(context, listen: false)
                    .login(username, password);

            if (success) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login failed')),
              );
            }
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Don\'t have an account? Register'),
        ),
      ],
    );
  }
}

import 'package:client/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/components/appbar_component.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _reffCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomAppBarClipper(),
            child: Container(
              height: 200.0,
              color: Theme.of(context).primaryColor,
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: kIsWeb ? _buildWebLayout() : _buildMobileLayout(),
              ),
            ),
          ),
        ],
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
              height: 300,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildRegisterForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRegisterForm(),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _fullnameController,
          decoration: const InputDecoration(
              labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
              labelText: 'Email', prefixIcon: Icon(Icons.email)),
        ),
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(
              labelText: 'Phone', prefixIcon: Icon(Icons.phone)),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
              labelText: 'Password', prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        TextField(
          controller: _password2Controller,
          decoration: const InputDecoration(
              labelText: 'Konfirmasi Password', prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        TextField(
          controller: _reffCodeController,
          decoration: const InputDecoration(
              labelText: 'Referral Code',
              prefixIcon: Icon(Icons.connect_without_contact)),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () async {
            final fullname = _fullnameController.text;
            final email = _emailController.text;
            final phone = _phoneController.text;
            final password = _passwordController.text;
            final reffCode = _reffCodeController.text;

            if (await Provider.of<AuthProvider>(context, listen: false)
                .register(fullname, email, phone, password, reffCode)) {
              Navigator.pushReplacementNamed(context, '/otp');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Register failed')),
              );
            }
          },
          label: const Text('Register'),
          icon: const Icon(Icons.app_registration),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text('Already have an account? Login'),
        ),
      ],
    );
  }
}

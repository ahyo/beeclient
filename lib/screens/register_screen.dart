import 'package:client/components/custom_button.dart';
import 'package:client/components/custom_input.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/screens/otp_screen.dart';
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
        CustomInputField(
          controller: _fullnameController,
          labelText: 'Full Name',
        ),
        CustomInputField(
          controller: _emailController,
          labelText: 'Email',
        ),
        CustomInputField(
          controller: _phoneController,
          labelText: 'Phone',
        ),
        CustomInputField(
          controller: _passwordController,
          labelText: 'Password',
          obscureText: true,
        ),
        CustomInputField(
          controller: _reffCodeController,
          labelText: 'Referral Code',
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Register',
          onPressed: () async {
            final fullname = _fullnameController.text.trim();
            final email = _emailController.text.trim();
            final phone = _phoneController.text.trim();
            final password = _passwordController.text.trim();
            final reffCode = _reffCodeController.text.trim();

            if (fullname.isEmpty ||
                email.isEmpty ||
                phone.isEmpty ||
                password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are required')),
              );
              return;
            }

            bool success =
                await Provider.of<AuthProvider>(context, listen: false)
                    .register(fullname, email, phone, password, reffCode);

            if (success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(email: email)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration failed')),
              );
            }
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Already have an account? Login'),
        ),
      ],
    );
  }
}

import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, '/login')},
            iconSize: 24,
            icon: const Icon(Icons.login),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, '/register')},
            icon: const Icon(Icons.app_registration),
            iconSize: 24,
            color: Colors.white,
          )
        ],
      ),
      body: const Text('Home'),
    );
  }
}

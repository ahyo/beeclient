import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        toolbarOpacity: 1,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Client Area',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Create Live Account'),
              onTap: () {
                // Handle create live account action
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Demo Account'),
              onTap: () {
                // Handle demo account action
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Live Account'),
              onTap: () {
                // Handle live account action
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Deposit'),
              onTap: () {
                // Handle deposit action
              },
            ),
            ListTile(
              leading: const Icon(Icons.money_off),
              title: const Text('Withdraw'),
              onTap: () {
                // Handle withdraw action
              },
            ),
            ListTile(
              leading: const Icon(Icons.notification_important),
              title: const Text('Notification'),
              onTap: () {
                // Handle withdraw action
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
              Navigator.pushReplacementNamed(
                context,
                '/login',
              ); // Or your initial route
            },
          ),
        ],
      ),
      body: Center(child: Text('Welcome, ${authProvider.user?.email}!')),
    );
  }
}

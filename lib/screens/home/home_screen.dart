import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authStore.logOut(),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}

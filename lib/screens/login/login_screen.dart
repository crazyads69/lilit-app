import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';
import 'package:lilit/stores/message_store/message_store.dart';
import 'package:lilit/widgets/accent_button/accent_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final messageStore = Provider.of<MessageStore>(context);

    return Observer(
      builder: (_) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            AccentButton(
              text: 'Login',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await authStore.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                  print('User: ${authStore.user}');
                }
              },
            ),
            // if (authStore.isLoading) CircularProgressIndicator(),
            // if (messageStore.latestMessage != null)
            //   Text(
            //     messageStore.latestMessage!.message,
            //     style: TextStyle(
            //       color: messageStore.latestMessage!.type == MessageType.error
            //           ? Colors.red
            //           : Colors.green,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/router/app_router.dart';
import 'package:lilit/schemas/auth_input/auth_input.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';

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
    final authStore = getIt<AuthStore>();

    return Observer(
      builder: (_) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) => EzValidator<String>()
                  .required(
                    "Email không được để trống",
                  )
                  .email(
                    "Email không hợp lệ",
                  )
                  .build()(value),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) => EzValidator<String>()
                  .required(
                    "Mật khẩu không được để trống",
                  )
                  .minLength(8, "Mật khẩu phải có ít nhất 8 ký tự")
                  .matches(
                      RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]).*$'),
                      "Mật khẩu phải chứa ít nhất 1 ký tự hoa, 1 ký tự thường, 1 số và 1 ký tự đặc biệt")
                  .build()(value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: (authStore.loginState.isLoading ||
                      authStore.loginState.isRefreshing)
                  ? CircularProgressIndicator()
                  : Text('Login'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  LoginInput loginInput = LoginInput(
                    email: _emailController.text,
                    password: _passwordController.text,
                    deviceId: authStore.deviceId!,
                  );
                  // In your login method within LoginScreen
                  await authStore.login(loginInput);
                  if (authStore.isAuthenticated) {
                    context.router.replace(HomeRoute());
                  }
                }
              },
            ),
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

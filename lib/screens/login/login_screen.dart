import 'package:auto_route/auto_route.dart';
import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/router/app_router.dart';
import 'package:lilit/schemas/auth_input/auth_input.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';
import 'package:lilit/app_theme.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Chào mừng bạn đến với LILIT',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Đăng nhập để trải nghiệm tốt nhất',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  Card(
                    shadowColor: AppColors.neutralDark,
                    elevation: 8,
                    color: AppColors.neutralDark,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: AppColors.neutral600, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();

    return Observer(
      builder: (_) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) => EzValidator<String>()
                  .required("Email không được để trống")
                  .email("Email không hợp lệ")
                  .build()(value),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: _obscurePassword,
              validator: (value) => EzValidator<String>()
                  .required("Mật khẩu không được để trống")
                  .minLength(6, "Mật khẩu phải có ít nhất 6 ký tự")
                  .matches(
                    RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]).*$'),
                    "Mật khẩu phải chứa ít nhất 1 ký tự hoa, 1 ký tự thường, 1 số và 1 ký tự đặc biệt",
                  )
                  .build()(value),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  LoginInput loginInput = LoginInput(
                    email: _emailController.text,
                    password: _passwordController.text,
                    deviceId: authStore.deviceId!,
                  );
                  await authStore.login(loginInput);
                  if (authStore.isAuthenticated) {
                    context.router.replace(HomeRoute());
                  }
                }
              },
              child: (authStore.loginState.isLoading ||
                      authStore.loginState.isRefreshing)
                  ? SizedBox(
                      width: 24, height: 24, child: CircularProgressIndicator())
                  : Text('Đăng nhập'),
            ),
            SizedBox(height: 16),
            TextButton(
              child: Text('Quên mật khẩu?'),
              onPressed: () {
                // TODO: Implement forgot password functionality
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

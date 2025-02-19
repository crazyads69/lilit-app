import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/api/api_service/api_service.dart';
import 'package:lilit/app_theme.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/screens/home/home_screen.dart';
import 'package:lilit/screens/login/login_screen.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';
import 'package:lilit/stores/message_store/message_store.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => getIt<ApiService>()),
        Provider<AuthStore>(create: (_) => getIt<AuthStore>()),
        Provider<MessageStore>(create: (_) => getIt<MessageStore>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Observer(
      builder: (_) => MaterialApp(
        title: 'LILIT',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        home: authStore.accessToken != null ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}

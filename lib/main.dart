import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/api/api_service/api_service.dart';
import 'package:lilit/app_theme.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/router/app_router.dart';
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
        Provider<AppRouter>(create: (_) => getIt<AppRouter>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = Provider.of<AppRouter>(context);

    return Observer(
      builder: (_) => MaterialApp.router(
          title: 'LILIT',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: ThemeMode.system,
          routerConfig: _appRouter.config()),
    );
  }
}

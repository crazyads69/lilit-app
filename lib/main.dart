import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lilit/app_theme.dart';
import 'package:lilit/di/service_locator.dart';
import 'package:lilit/router/app_router.dart';
import 'package:lilit/stores/auth_store/auth_store.dart';
import 'package:lilit/stores/message_store/message_store.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    final messageStore = getIt<MessageStore>();

    return Observer(
      builder: (_) {
        return MaterialApp.router(
          title: 'LILIT',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: ThemeMode.system,
          routerConfig: appRouter.config(),
          builder: (context, child) {
            return Scaffold(
              body: child,
              // Add a reaction to show SnackBar when a new message is added
              bottomSheet: Observer(
                builder: (_) {
                  if (messageStore.messages.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showSnackBar(context, messageStore.messages.last);
                      messageStore.removeMessage(messageStore.messages.last.id);
                    });
                  }
                  return SizedBox.shrink();
                },
              ),
            );
          },
        );
      },
    );
  }

  void showSnackBar(BuildContext context, Message message) {
    Color backgroundColor;
    IconData iconData;

    switch (message.type) {
      case MessageType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case MessageType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case MessageType.info:
        backgroundColor = Colors.blue;
        iconData = Icons.info;
        break;
      case MessageType.warning:
        backgroundColor = Colors.orange;
        iconData = Icons.warning;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.message, style: TextStyle(color: Colors.white)),
                if (message.description != null)
                  Text(
                    message.description!,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Đóng',
        textColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

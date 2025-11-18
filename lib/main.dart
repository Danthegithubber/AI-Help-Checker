import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'screens/welcome_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'AI Help Checker',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.black,
        barBackgroundColor: CupertinoColors.white,
        scaffoldBackgroundColor: CupertinoColors.white,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CupertinoPage(child: const WelcomePage());
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CupertinoPage(child: const LoginPage());
      },
    ),
  ],
);

import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: null,
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Page',
                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                  fontFamily: 'Arimo',
                  color: const Color(0xFF0a0a0a),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This page will be implemented by your teammate',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontFamily: 'Arimo',
                  color: const Color(0xFF717182),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

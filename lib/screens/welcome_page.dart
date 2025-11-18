import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom),
            child: Column(
              children: [
                SizedBox(height: isSmallScreen ? 8 : 16),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 96,
                          height: 96,
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 24 : 32),
                        Text(
                          'AI Help Checker',
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                            fontFamily: 'Arimo',
                            color: const Color(0xFF0a0a0a),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Get instant, accurate feedback on your questions powered by advanced AI',
                            textAlign: TextAlign.center,
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontFamily: 'Arimo',
                              color: const Color(0xFF717182),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 24 : 32),
                        _FeaturesList(isSmallScreen: isSmallScreen),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CupertinoButton(
                      color: CupertinoColors.black,
                      borderRadius: BorderRadius.circular(14),
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        'Continue',
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontFamily: 'Arimo',
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturesList extends StatelessWidget {
  final bool isSmallScreen;

  const _FeaturesList({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': 'assets/images/icon-1.svg',
        'title': 'AI-Powered Analysis',
        'description': 'Advanced algorithms analyze your questions in seconds',
      },
      {
        'icon': 'assets/images/icon-2.svg',
        'title': 'Accurate Results',
        'description': 'Get reliable feedback you can trust every time',
      },
      {
        'icon': 'assets/images/icon-3.svg',
        'title': 'Instant Feedback',
        'description': 'No waiting around — receive results immediately',
      },
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: SvgPicture.asset(
                  feature['icon']!,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title']!,
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        fontFamily: 'Arimo',
                        color: const Color(0xFF0a0a0a),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature['description']!,
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        fontFamily: 'Arimo',
                        color: const Color(0xFF717182),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

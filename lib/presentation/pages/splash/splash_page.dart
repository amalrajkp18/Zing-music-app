import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:zing/core/utils/white_space.dart';
import 'package:zing/presentation/providers/splash_provider/splash_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(splashProvider).when(
          // after compelete navigate home page
          data: (data) => data,
          // when error occur
          error: (error, stackTrace) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //error text
                  Text(
                    "error ${error.toString()}",
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                  // height space
                  WhiteSpace.space(context: context, height: 20),
                  // button invalidate provider
                  ElevatedButton(
                    onPressed: () async {
                      ref.invalidate(splashProvider);
                    },
                    child: Text(
                      "Grant Permmission",
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ),
          ),
          // splash screen
          loading: () => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app logo
                  Image.asset(
                    "assets/images/img_app_logo.png",
                    width: context.width(120),
                  ),
                  //height spacer
                  WhiteSpace.space(context: context, height: 10),
                  //app name
                  Text(
                    "Zing",
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
        );
  }
}

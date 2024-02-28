import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/presentation/providers/splash_provider/splash_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(splashProvider).when(
          // after compelete navigate home page
          data: (data) => data,
          // when error occur
          error: (error, stackTrace) => Center(
            child: Text("error ${error.toString()}"),
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
                    style: GoogleFonts.pacifico(
                      color: AppColors.white,
                      fontSize: context.width(26),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}

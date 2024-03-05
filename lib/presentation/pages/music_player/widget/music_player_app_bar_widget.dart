import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';
import 'package:text_scroll/text_scroll.dart';

AppBar musicPlayerAppBarWidget({required BuildContext context}) {
  return AppBar(
    // back button
    leading: MusicButtonWidget(
      icon: Icons.arrow_back_ios,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    // song title
    title: Consumer(
      builder: (context, ref, _) => TextScroll(
        ref
                .watch(songsProvider)
                .value?[ref.watch(currentIndexProvider) ?? 0]
                .title ??
            "",
        style: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(18),
          fontWeight: FontWeight.w600,
        ),
        numberOfReps: 2,
        delayBefore: const Duration(seconds: 1),
      ),
    ),
    centerTitle: true,
    actions: [
      // fav button
      MusicButtonWidget(
        icon: Icons.favorite_outline,
        onPressed: () {},
      ),
    ],
  );
}

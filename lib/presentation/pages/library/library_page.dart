import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import 'widget/liked_music_tile_widge.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: Text(
          "Your Library",
          style: GoogleFonts.nunito(
            color: AppColors.white,
            fontSize: context.width(24),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          MusicButtonWidget(
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(
        children: [
          LikedMusicTileWidget(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';

import 'widget/music_image_widget.dart';
import 'widget/music_playerapp_bar_widget.dart';
import 'widget/music_progress_widget.dart';
import 'widget/play_controller_button_widget.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({
    super.key,
  });
  static const String routeName = "/musicplayerpage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: musicPlayerAppBarWidget(
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width(30),
        ),
        child: Column(
          children: [
            // height space
            WhiteSpace.space(context: context, height: 80),
            //music image
            const MusicImageWidget(),
            // height space
            WhiteSpace.space(context: context, height: 80),
            // music progress bar
            const MusicProgressWidget(),
            // height space
            WhiteSpace.space(context: context, height: 70),
            // player controllers
            const PlayControllerButtonsWidget(),
            // mute and timestreching
          ],
        ),
      ),
    );
  }
}

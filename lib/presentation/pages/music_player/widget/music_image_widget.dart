import 'package:flutter/material.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';

class MusicImageWidget extends StatelessWidget {
  const MusicImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(304),
      height: context.height(314),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          context.width(36),
        ),
        image: const DecorationImage(
          image: AssetImage("assets/images/img_music_list.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

class MusicTileWidget extends StatelessWidget {
  const MusicTileWidget({
    super.key,
    required this.songName,
    required this.singer,
    this.textWidgetWidth = 290,
    this.isLibary = false,
    this.isLiked = false,
    this.textCount = 65,
    this.librayPressed,
  });
  final String songName;
  final String singer;
  final double textWidgetWidth;
  final bool isLibary;
  final bool isLiked;
  final int textCount;
  final VoidCallback? librayPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(15),
        vertical: context.height(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width(5)),
        width: context.width(350),
        height: context.height(105),
        child: Row(
          children: [
            // music thumbnail
            CircleAvatar(
              radius: context.width(35),
              backgroundImage:
                  const AssetImage("assets/images/img_music_list.png"),
            ),
            // width spacer
            WhiteSpace.space(context: context, width: 20),
            //music title and singer
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // music title
                SizedBox(
                  width: context.width(textWidgetWidth),
                  child: Text(
                    songName.length > textCount
                        ? songName.substring(0, textCount)
                        : songName,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.clip,
                  ),
                ),
                // height space
                WhiteSpace.space(context: context, height: 5),
                // singer name
                Text(
                  singer,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            // width space
            const Spacer(),
            // libary section button
            isLibary
                ? MusicButtonWidget(
                    icon: isLiked ? Icons.favorite : Icons.delete,
                    iconColor: isLiked ? Colors.red : AppColors.white,
                    onPressed: librayPressed == null ? () {} : librayPressed!,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

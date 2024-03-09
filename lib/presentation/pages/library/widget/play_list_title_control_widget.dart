import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';

Future<dynamic> playlistTtileControlWidget({
  required BuildContext context,
  required TextEditingController textEditingController,
  required VoidCallback onPressed,
  bool isEdit = false,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (context) => Container(
      width: context.width(430),
      padding: EdgeInsets.symmetric(
        horizontal: context.width(50),
      ),
      color: AppColors.scaffoldBg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // title
          Text(
            "Give your playlist a name",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // height space
          WhiteSpace.space(context: context, height: 30),
          // field content
          TextField(
            controller: textEditingController,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "My Playlist #3",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grey,
                  width: 2,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
            ),
          ),
          // height space
          WhiteSpace.space(context: context, height: 40),
          // button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // cancel button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.width(25),
                    ),
                    side: const BorderSide(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                onPressed: () {
                  textEditingController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              //create or edit button
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  isEdit ? "Edit" : "Create",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

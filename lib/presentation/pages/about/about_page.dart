import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:zing/core/utils/white_space.dart';

import 'widget/about_desc_text_widget.dart';
import 'widget/about_head_text_widget.dart';
import 'widget/social_media_icons_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.width(70),
        leading: Padding(
          padding: EdgeInsets.only(left: context.width(10)),
          child: Image.asset("assets/images/img_app_logo.png"),
        ),
        // app title
        title: Text(
          "Zing",
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // height space
            WhiteSpace.space(context: context, height: 30),
            // text about
            const AboutHeadTextWidget(
              text: "About Zing",
            ),
            // height space
            WhiteSpace.space(context: context, height: 10),
            // text desc about
            const AboutDescTextWidget(
              text:
                  "Your ultimate music companion! At Zing, we're passionate about connecting people with the music they love and empowering them to discover new sounds from around the world.",
            ),
            // height space
            WhiteSpace.space(context: context, height: 30),
            const AboutHeadTextWidget(
              text: "Contact Us",
            ),
            // height space
            WhiteSpace.space(context: context, height: 10),
            // text desc about
            const AboutDescTextWidget(
              text:
                  "Have questions or feedback? We'd love to hear from you! Reach out to us at amalrajkp18@gmail.com or connect with us on social media:",
            ),
            // height space
            WhiteSpace.space(context: context, height: 40),
            // connect apps
            const SocialMediaIconsWidget(),
            // height space
            WhiteSpace.space(context: context, height: 80),
            // privacy policy
            Text(
              "Privacy Policy | Terms of Service | Copyright © 2024 Zing Music. All rights reserved.",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: AppColors.grey,
                fontSize: context.width(15),
              ),
            ),
            // height space
            WhiteSpace.space(context: context, height: 40),
            // version
            Center(
              child: Text(
                "version 0.0.1",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: AppColors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

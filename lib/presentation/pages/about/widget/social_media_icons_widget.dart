import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIconsWidget extends StatelessWidget {
  const SocialMediaIconsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () async {
            await launchUrl(Uri.parse('https://github.com/amalrajkp18'));
          },
          child: FaIcon(
            FontAwesomeIcons.github,
            color: AppColors.white,
            size: context.width(40),
          ),
        ),
        InkWell(
          onTap: () async {
            await launchUrl(Uri.parse('linkedin.com/in/amal-raj-k-p'));
          },
          child: FaIcon(
            FontAwesomeIcons.linkedin,
            color: AppColors.white,
            size: context.width(40),
          ),
        ),
        InkWell(
          onTap: () async {
            await launchUrl(
              Uri.parse('https://www.instagram.com/amal_raj_k_p/'),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.instagram,
            color: AppColors.white,
            size: context.width(40),
          ),
        ),
        InkWell(
          onTap: () async {
            await launchUrl(
              Uri.parse('https://wa.me/919072131462'),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: AppColors.white,
            size: context.width(40),
          ),
        ),
        InkWell(
          onTap: () async {
            await launchUrl(
              Uri.parse('https://amalrajkp18.github.io/'),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.earthAsia,
            color: AppColors.white,
            size: context.width(40),
          ),
        ),
      ],
    );
  }
}

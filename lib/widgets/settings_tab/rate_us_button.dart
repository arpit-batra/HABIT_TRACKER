import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/settings_tab/settings_button_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUsButton extends StatelessWidget {
  const RateUsButton({super.key});
  final String packageName = 'com.arpitbatra98.knuckle';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final String url = 'market://details?id=$packageName';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      },
      child: SettingsButtonWrapper(
        child: Text(
          'Rate Us',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

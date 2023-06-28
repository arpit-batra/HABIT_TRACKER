import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/settings_tab/settings_button_wrapper.dart';

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (ctx) {
                    return const Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('9996836502'),
                        ),
                        ListTile(
                          leading: Icon(Icons.mail),
                          title: Text('arpitbatra98@gmail.com'),
                        ),
                      ],
                    );
                  });
            });
      },
      child: SettingsButtonWrapper(
        child: Text(
          "Contact Us",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

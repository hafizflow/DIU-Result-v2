import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:riverpod_practice/core%20/constants/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DevInfo extends StatelessWidget {
  const DevInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: ColorConstants.offDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text:
                              "Assalamu Alaikum, "
                              "Thank you for using this application. Please note that this app relies entirely on DIU server to display results. "
                              "During times of high traffic, the server may become overcrowded, which could cause delays in loading the results. "
                              "I kindly ask for your patience and understanding.\n\n"
                              "Developed By ",
                        ),
                        TextSpan(
                          text: "Hafizur Rahman",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.contentColorBlue,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                    Uri.parse(
                                      'https://www.facebook.com/share/1J8wLCzhDG/?mibextid=wwXIfr',
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        borderRadius: BorderRadius.circular(5),
        child: const Icon(
          Iconsax.personalcard_copy,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}

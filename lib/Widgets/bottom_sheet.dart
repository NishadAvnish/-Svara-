import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/player_widget.dart';

Future<void> showBotomSheet(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, controller) {
              return  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: screenGradientColor,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:15,bottom:15),
                      child: PlayerWidget(
                        homeClickedIndex: 1,
                        flag: "now playing",
                      ),
                    ),
              );
            });
      });
}
